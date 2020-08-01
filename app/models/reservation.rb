class Reservation < ApplicationRecord
  enum instant: {Waiting: 0, Approved: 1, Declined: 2}
  
  belongs_to :user
  belongs_to :pool
  
  scope :current_week_revenue, -> (user) {
    joins(:pool)
    .where("pools.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, 1)
    .order(updated_at: :asc)
  }

  private

    def create_notification
      type = self.pool.Instant? ? "New Booking" : "New Request"
      client = User.find(self.user_id)

      Notification.create(content: "#{type} from #{client.fullname}", user_id: self.pool.user_id)
    end
end
