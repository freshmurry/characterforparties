Rails.configuration.stripe = {
  #---- TEST ----
  # :publishable_key => 'pk_test_SZlZj99vzoclqVZRRLswAQ8h',
  # :secret_key => 'sk_test_f4TIZbC578AuDRAuSQwIXhIg'
  
  #---- LIVE ----
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]