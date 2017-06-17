class Admin::UserGroupsController < AdminController

  def index
    @groups = UserGroup.all
  end

  def new
    @user_group = UserGroup.new
    @difficulties = Label.where(category: '难度')
    @subjects = Label.where(category: '题型')
    @books = Label.where(category: '来源')
  end

  def create
    @user_group = UserGroup.new(user_group_params)
    if @user_group.save
      flash[:notice] = "保存成功"
    else
      flash[:notice] = '保存失败'
    end
    redirect_to edit_admin_user_group_path(@user_group)
  end

  def edit
    @user_group = UserGroup.find params[:id]
    @difficulties = Label.where(category: '难度')
    @subjects = Label.where(category: '题型')
    @books = Label.where(category: '来源')
  end

  def update
    @group = UserGroup.find params[:id]
    @group.update(user_group_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_user_group_path(@group)
  end

  private

  def user_group_params
    params.require(:user_group).permit(:valid_to, :name, {:label_ids => []})
  end

end
