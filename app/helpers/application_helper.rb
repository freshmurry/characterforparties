module ApplicationHelper
  def avatar_url(user)
    if user.image
      "https://graph.facebook.com/#{user.uid}/picture?type=large"
    else
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
    end
  end
  
  def stripe_express_path
  # ---- LIVE ----
  "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=ca_ByR5qEQGduFZMoLMA89FFdEB0IiNoAOs&scope=read_write"
  # ---- TEST ----
  # "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=ca_ByR56BlIUtm498dyVTmmz1Oq2nz2DYtN&scope=read_write"
  end
end