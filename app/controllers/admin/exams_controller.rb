class Admin::ExamsController < AdminController

  def index
    @exams = Exam.all
  end

  def new
    @exam = Exam.new
  end

  def edit
    @exam = Exam.find params[:id]
  end

  def update
    @exam = Exam.find params[:id]
    
    if @exam.update(exam_params)
      flash[:notice] = "保存成功"
    else
      flash[:notice] = '保存失败'
    end
    redirect_to edit_admin_exam_path(@exam)
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      flash[:notice] = "保存成功"
    else
      flash[:notice] = '保存失败'
    end
    redirect_to edit_admin_exam_path(@exam)
  end

  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy
    redirect_to admin_exam_path
  end

  private

  def exam_params
    params.require(:exam).permit(:name, :exam_type, :exercises, :estimated_time)
  end
end
