class Admin::SessionsController < AdminController
  layout 'simple'

  def new
  end

  def destroy
  end

  def create
    user = AdminUser.find_by(name: params[:session][:name].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:admin_user_id] = user.id
      redirect_to '/admin'
    else
      flash[:danger] = '用户名密码错误'
      render 'new'
    end
  end
end
