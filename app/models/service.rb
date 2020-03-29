class Service < ApplicationRecord
  # enum status: {Waiting: 0, Approved: 1, Declined: 2}
  
  # after_create_commit :create_notification
  
  belongs_to :venue
  
  # validates :title, presence: true
  # validates :price, presence: true
  
  # private

  #   def create_notification
  #     type = self.venue.Instant? ? "New Booking" : "New Request"
  #     guest = User.find(self.user_id)

  #     Notification.create(content: "#{type} from #{guest.fullname}", user_id: self.venue.user_id)
  #   end
end
