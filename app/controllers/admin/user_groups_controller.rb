class Admin::UserGroupsController < AdminController

  def index
    @groups = UserGroup.all
  end

  def new
    @user_group = UserGroup.new
  end

  def create
    @user_group = UserGroup.new(user_group_params)
    if @user_group.save
      flash[:notice] = "保存成功"
      redirect_to edit_admin_user_group_path(@user_group)
    else
      render "admin/user_groups/new"
    end
    
  end

  def edit
    @user_group = UserGroup.find params[:id]
  end

  def update
    @user_group = UserGroup.find params[:id]
    if @user_group.update(user_group_params)
      flash[:notice] = '保存成功'
      redirect_to edit_admin_user_group_path(@user_group)
    else
      render "admin/user_groups/edit"
    end
  end

  def add_users
    group = UserGroup.find params[:id]
    current_ids = group.user_ids
    group.user_ids = current_ids | params[:user_ids]
    render json: { success: 1 }
  end

  def users
    @group = UserGroup.find params[:id]
    @users = @group.users.order(created_at: :desc)
  end

  def remove_user
    @group = UserGroup.find params[:id]
    @group.users.delete params[:user_id]
    render json: { success: 1 }
  end

  private

  def user_group_params
    params.require(:user_group).permit(:valid_to, :name, {:label_ids => []})
  end

end
