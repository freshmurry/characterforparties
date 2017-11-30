Rails.configuration.stripe = {
  :publishable_key => 'pk_test_hh96iSsb8UnLNrA9S1aNYNTQ',
  :secret_key => 'sk_test_25ExbWKt6MIfjnJkgUSVHI6P'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]