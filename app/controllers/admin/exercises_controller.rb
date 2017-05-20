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
    @difficulties = Label.where(category: '难度')
    @subjects = Label.where(category: '题型')
    @books = Label.where(category: '来源')
  end

  private

  def exercise_params
    params.require(:exercise).permit(:title, {:choices => []}, :anwser,
      {:guides => []}, :video_url, :exercise_tags,
      {:label_ids => []}, :exclusive)
  end

end
