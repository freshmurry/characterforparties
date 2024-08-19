class Review < ApplicationRecord
  belongs_to :character
  belongs_to :reservation
  belongs_to :guest, class_name: "User" # Assuming guest is the reviewer
  belongs_to :host, class_name: "User", optional: true # Assuming host is the owner of the character

  # Validations
  validates :character, presence: true
  validates :reservation, presence: true
  validates :guest, presence: true
  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 } # Assuming ratings are between 1 and 5

  validate :user_has_reservation_for_character
  validate :reservation_date_passed

  private

  def user_has_reservation_for_character
    if reservation.user_id != guest.id || reservation.character_id != character.id
      errors.add(:base, "User must have a valid reservation for this booking to leave a review.")
    end
  end

  def reservation_date_passed
    if reservation.reservation_date > Date.today
      errors.add(:base, "You cannot leave a review until after your scheduled reservation date.")
    end
  end
end
