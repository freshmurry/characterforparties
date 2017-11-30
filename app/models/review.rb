class Review < ApplicationRecord
  belongs_to :barbershop
  belongs_to :reservation
  belongs_to :barber
  belongs_to :client
end
