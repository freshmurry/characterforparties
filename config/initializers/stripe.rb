Rails.configuration.stripe = {
  #---- TEST ----
  # :publishable_key => 'pk_test_vo9J2U9984kIRlQQgnpdKgAw',
  # :secret_key => 'sk_test_lvX0KUqSHUGyfjoughDVVcCe'
  
  #---- LIVE ----
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]