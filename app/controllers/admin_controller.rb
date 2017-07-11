class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'admin'

  def current_user
    @current_user ||= AdminUser.find(session[:admin_user_id]) if session[:admin_user_id]
  end

  helper_method :current_user
end
