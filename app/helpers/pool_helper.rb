module PoolHelper
  def purchased_service(service)
    user_signed_in? && current_user.include?("#{service.title.parameterize}-service_#{service.id}")
  end
end
