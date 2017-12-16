Rails.configuration.stripe = {
  #---- TEST ----
  # :publishable_key => 'pk_test_SZlZj99vzoclqVZRRLswAQ8h',
  # :secret_key => 'sk_test_f4TIZbC578AuDRAuSQwIXhIg'
  #---- LIVE ----
  :publishable_key => 'pk_live_5W1sDTDyDdGGd5QtelSvq2yZ',
  :secret_key => 'sk_live_6bAj5v6njneQEc7hbx6Hn99Z'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]