class Admin::ExercisesController < AdminController
  before_action :set_labels

  def index
    @exercises = Exercise.order(created_at: :desc)
  end

  def new
    @exercise = Exercise.new
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])
    @exercise.update(exercise_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_exercise_path(@exercise)
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      flash[:notice] = "保存成功"
    else
      flash[:notice] = '保存失败'
    end
    redirect_to edit_admin_exercise_path(@exercise)
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    redirect_to admin_exercises_path
  end

  def set_labels
    @difficulties = ['500-600', '600-700', '700-750', '750以上']
    @subjects = ['语法SC', '逻辑CR', '阅读RC', '数学PS', '数学DS', '作文AWA', '推理IR']
    @books = ['OG12', 'OG15', 'OG16', 'OG17', 'Prep07', 'Manhattan']
  end

  private

  def exercise_params
    params.require(:exercise).permit(:title, {:choices => []}, :anwser,
      {:guides => []}, :video_url, :exercise_tags,
      {:book => []}, {:subject => []}, {:difficulty => []})
  end

end
