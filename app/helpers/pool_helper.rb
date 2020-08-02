module PoolHelper
<<<<<<< HEAD
=======
  def purchased_service(service)
    user_signed_in? && current_user.include?("#{service.title.parameterize}-service_#{service.id}")
  end
>>>>>>> 3906278811c5dda65e4ada8b7ad8477deef7fa61
end
