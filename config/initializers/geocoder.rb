# Geocoder.configure(
#   units: :mi,
#   :timeout=>15
# )

# Geocoder::Configuration.timeout = 15

# Geocoder.configure(
#   # Geocoding options
#   lookup: :google,
#   api_key: ENV['GOOGLE_API_KEY'], # Set your API key here
#   timeout: 5
# )

Geocoder.configure(
  # Geocoding options
  lookup: :google,         
  api_key: ENV['GOOGLE_API_KEY'], 
  timeout: 15,
  units: :mi,
  use_https: true,
  language: :en
)
