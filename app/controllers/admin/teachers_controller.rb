class Admin::TeachersController < AdminController

  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def create
    @teacher = Teacher.new(teacher_params)
    @teacher.save
    flash[:notice] = "保存成功"
    redirect_to edit_admin_teacher_path(@teacher)
  end

  def update
    @teacher = Teacher.find(params[:id])
    @teacher.update(teacher_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_teacher_path(@teacher)
  end

  def destroy
    Teacher.destroy(params[:id])
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :description, :avatar, :long_name)
  end
end
