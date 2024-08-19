require 'rails_helper'

RSpec.describe Character, type: :model do
  it "uploads photos successfully" do
    character = Character.create(
      character_type: 'Castle',
      time_limit: '4hrs.',
      pickup_type: 'Same Day Pickup',
      instant: 'Request',
      listing_name: 'Fun Castle',
      description: 'A fun castle for kids.',
      address: '123 Fun St',
      price: 100.00
    )
    
    photo = Photo.create(
      image: fixture_file_upload('files/blank.jpg'),
      character: character
    )
    
    expect(photo).to be_persisted
    expect(character.photos.count).to eq(1)
  end
end
