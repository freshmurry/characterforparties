class Review < ApplicationRecord
  belongs_to :pool
  belongs_to :reservation
  belongs_to :host
  belongs_to :guest
end
