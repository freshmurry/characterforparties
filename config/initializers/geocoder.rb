# Geocoder.configure(
#   units: :mi,
#   :timeout=>15
# )

Geocoder.configure(
  lookup: :google,
  api_key: 'AIzaSyCCa0Y1ZKXoASepQNlMeYoUO6pLZIwAovg',
  units: :mi
  timeout: 15
)

# Geocoder.configure(
#   # Geocoding options
#   lookup: :google,
#   api_key: ENV['GOOGLE_API_KEY'], # Set your API key here
#   timeout: 5
# )

# Geocoder.configure(
#   # Geocoding options
#   lookup: :google,         
#   api_key: ENV['GOOGLE_API_KEY'], 
#   timeout: 15,
#   units: :mi,
#   use_https: true,
#   language: :en
# )
