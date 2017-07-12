class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'admin'

  before_action :logged_in

  def current_user
    @current_user ||= AdminUser.find(session[:admin_user_id]) if session[:admin_user_id]
  end

  helper_method :current_user

  def logged_in
    if current_user.blank?
      redirect_to '/admin/login'
    end
  end
end
