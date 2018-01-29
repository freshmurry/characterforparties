Rails.configuration.stripe = {
  #---- TEST ----
  # :publishable_key => 'pk_test_WYMTzyGZ9KXIM7ckP4mIDQEa',
  # :secret_key => 'sk_test_uQnVqs5Vnt9upqbJJNCSmiYy'
  
  #---- LIVE ----
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]