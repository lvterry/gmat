class Admin::AdminUsersController < AdminController

  skip_before_action :logged_in

  def index
    @admin_users = AdminUser.all
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      flash[:notice] = "保存成功"
    else
      flash[:notice] = '保存失败'
    end
    redirect_to edit_admin_admin_user_path(@admin_user)
  end

  def edit
    @admin_user = AdminUser.find params[:id]
  end

  def update
    @admin_user = AdminUser.find(params[:id])
    @admin_user.update(admin_user_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_admin_user_path(@admin_user)
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:name, :password, :password_confirmation)
  end
end
