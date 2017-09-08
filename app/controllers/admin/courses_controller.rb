class Admin::CoursesController < AdminController
  #before_action :get_tags

  def index
    @courses = Course.order(created_at: :desc)
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    @course.update(course_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_course_path(@course)
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = "保存成功"
    else
      flash[:notice] = '保存失败'
    end
    redirect_to edit_admin_course_path(@course)
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to admin_courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :img_url,
      :start_time, :end_time, :subject, :fee, :link, :video_id, :seq,
      :teacher_id)
  end

end
