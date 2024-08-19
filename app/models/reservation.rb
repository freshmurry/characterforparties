class Reservation < ApplicationRecord
  enum status: { Waiting: 0, Approved: 1, Declined: 2 }

  after_create_commit :create_notification

  belongs_to :user
  belongs_to :character

  validates :start_date, :end_date, :character_id, presence: true

  scope :current_week_revenue, -> (user) {
    joins(:character)
    .where("characters.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, statuses[:Approved])
    .order(updated_at: :asc)
  }

  def self.is_conflict(character, start_date, end_date)
    character.reservations.where("start_date < ? AND end_date > ?", end_date, start_date).exists?
  end

  def booking_fee
    return 0 if total.nil? || total.zero?
    total * 0.05 # 5% booking fee
  end

  private

  def create_notification
    type = self.character.Instant? ? "New Booking" : "New Request"
    guest = User.find(self.user_id)

    Notification.create(content: "#{type} from #{guest.fullname}", user_id: self.character.user_id)
  end
end
