class Admin::UserGroupsController < AdminController

  def index
    @groups = UserGroup.order(updated_at: :desc)
  end

  def new
    @user_group = UserGroup.new
  end

  def create
    #@user_group = UserGroup.new
    @user_group = build_user_group params
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
    @user_group = build_user_group params
    if @user_group.save
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
    params.require(:user_group).permit(:valid_to, :name, {:permissions => [[:label_id, :permission_type]]})
  end

  def build_user_group(params)
    if params[:id]
      user_group = UserGroup.find(params[:id])
    else
      user_group = UserGroup.new
    end
    user_group.name = params[:user_group][:name]
    user_group.valid_to = params[:user_group][:valid_to]
    user_group.permissions.clear

    params[:user_group][:permissions].each do |p|
      next if p[:label_id].nil?
      temp = user_group.permissions.new(label_id: p[:label_id])
      temp.permission_type = p[:permission_type] ? p[:permission_type] : 1
      temp.save
    end

    user_group.save

    return user_group
  end

end
