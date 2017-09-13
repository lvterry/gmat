class Admin::UsersController < AdminController

  def index
    if params[:group] && params[:group] != '0'
      @users = UserGroup.find(params[:group]).users
    else
      @users = User.order(pinyin: :asc)
    end
    @group = params[:group]
    @user_groups = UserGroup.order(created_at: :desc)
  end

  def edit
    @user = User.find params[:id]
    @difficulties = Label.where(category: '难度')
    @subjects = Label.where(category: '题型')
    @books = Label.where(category: '来源')
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_user_path(@user)
  end

  def lonely
    @users = User.left_outer_joins(:user_groups).where(user_groups: { id: nil }).order(created_at: :desc)
    @user_groups = UserGroup.all
  end

  def search
    @q = params[:q]
    @users = User.where("nickname LIKE ? OR mobile LIKE ?", "%#{@q}%", "%#{@q}%").order(created_at: :desc)
    @user_groups = UserGroup.all
    render 'index'
  end

  def show
    @user = User.find params[:id]
  end

  def check_permission
    @user = User.find params[:id]
    permission = @user.permission_type Exercise.find(params[:exerciseId])
    render json: { permission: permission }
  end

  private

  def user_params
    params.require(:user).permit(:valid_to, {:label_ids => []})
  end

end
