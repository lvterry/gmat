class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # only allow one session for one account
    if session[:user_id]
      user = User.find session[:user_id]
      if session.id == user.session_id
        @current_user = user
      else
        reset_session
      end
    end
    # @current_user = User.find 4
  end

  helper_method :current_user
end
