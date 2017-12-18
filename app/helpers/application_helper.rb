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
    "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=ca_BvZm6NBsxhq2zw0BWbuIGvXymsaDdlXY&scope=read_write"

  # ---- TEST ----
    # "https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=ca_BvZmyFOTeRGkcyhLyEcAVxGm7CvtBUDA&scope=read_write"
  end
end