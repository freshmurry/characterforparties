Rails.configuration.stripe = {
  :publishable_key => 'pk_test_SZlZj99vzoclqVZRRLswAQ8h',
  :secret_key => 'sk_test_f4TIZbC578AuDRAuSQwIXhIg'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]