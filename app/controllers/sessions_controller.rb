class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    if @user.mobile.blank?
      redirect_to update_mobile_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_back(fallback_location: root_path)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end