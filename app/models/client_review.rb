class ClientReview < Review
  belongs_to :client, class_name: "User"
end