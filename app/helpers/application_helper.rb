module ApplicationHelper
  def image(user)
    if user.image
      @user.image_url
    else
      "https://graph.facebook.com/#{user.uid}/picture?type=large"
      
      # gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      # "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
    end
  end
  
  # def image(user)
  #   if @user.image.empty?
  #     "assets/images/blank.jpg"
  #   else
  #     @user.image.url
  #   end
  # end
  
  def stripe_express_path
  # ----- TEST -----
  # "https://connect.stripe.com/express/oauth/authorize?redirect_uri=http://shindigspace-freshmurry.c9users.io:8080/auth/stripe_connect/callback&client_id=ca_Bz12s2Z5ijkGknATCnWx9EmDZIvGMf0e&state=read_write"
  # "https://connect.stripe.com/express/oauth/authorize?redirect_uri=http://shindigspace-freshmurry.c9users.io:8080/auth/stripe_connect/callback&client_id=ca_Bz12s2Z5ijkGknATCnWx9EmDZIvGMf0e&state={STATE_VALUE}"

  # ---- LIVE ----
  # "https://connect.stripe.com/express/oauth/authorize?redirect_uri=https://shindigspace.herokuapp.com/auth/stripe_connect/callback&client_id=ca_Bz129rceytBvxCIxgLptuWQeV6JayofE&state={STATE_VALUE}"
  "https://connect.stripe.com/express/oauth/authorize?redirect_uri=https://shindigspace.herokuapp.com/auth/stripe_connect/callback&client_id=ca_Bz129rceytBvxCIxgLptuWQeV6JayofE&state=read_write"

  end
end