class Reservation < ApplicationRecord
  enum instant: {Waiting: 0, Approved: 1, Declined: 2}
  
  belongs_to :user
  belongs_to :barbershop
  
  scope :current_week_revenue, -> (user) {
    joins(:barbershop)
    .where("barbershops.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, 1)
    .order(updated_at: :asc)
  }

  private

    def create_notification
      type = self.barbershop.Instant? ? "New Booking" : "New Request"
      client = User.find(self.user_id)

      Notification.create(content: "#{type} from #{client.fullname}", user_id: self.barbershop.user_id)
    end
end
