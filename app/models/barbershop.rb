class Barbershop < ApplicationRecord
  enum instant: {Request: 0, Instant: 1}
  
  belongs_to :user, required: false
  has_many :photos
  has_many :reservations
  
  has_many :barber_reviews
  has_many :calendars
  has_many :services

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  validates :location_type, presence: true
  validates :stylist_type, presence: true
  validates :style_type, presence: true
  validates :payment_type, presence: true
  validates :additional_service, presence: true

  def cover_photo(size)
    if self.photos.length > 0
      self.photos[0].image.url(size)
    else
      "blank.jpg"
    end
  end
  
  def average_rating
    barber_reviews.count == 0 ? 0 : barber_reviews.average(:star).round(2).to_i
  end
end