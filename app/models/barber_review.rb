class BarberReview < Review
  belongs_to :barber, class_name: "User"
end