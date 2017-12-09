class Reservation < ApplicationRecord
  enum instant: {Waiting: 0, Approved: 1, Declined: 2}
  
  belongs_to :user
  belongs_to :venue
  
  scope :current_week_revenue, -> (user) {
    joins(:venue)
    .where("venues.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, 1)
    .order(updated_at: :asc)
  }

  private

    def create_notification
      type = self.venue.Instant? ? "New Booking" : "New Request"
      host = User.find(self.user_id)

      Notification.create(content: "#{type} from #{host.fullname}", user_id: self.venue.user_id)
    end
end
