class Admin::ExercisesController < AdminController

  def index
    @q = params[:q]
    if filter_is_empty?(params[:filters])
      @filters = [0,0,0]
      labels = nil
    else
      @filters = params[:filters]
      labels = labels_for_search params[:filters]
    end

    search = Exercise.search do
      fulltext params[:q] if params[:q]
      with(:label_ids).all_of(labels) unless labels.nil?
      paginate page: params[:page] || 1, per_page: 20
    end
    @exercises = search.results
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

  private

  def exercise_params
    params.require(:exercise).permit(:title, :math_guide, {:choices => []}, :anwser,
      {:guides => []}, :video_url, :exercise_tags,
      {:label_ids => []}, :exclusive)
  end

  def filter_is_empty?(filters)
    return filters.nil? || (filters.join("") == "000")
  end

  def labels_for_search(filters)
    return filters.map { |item| item.to_i if item != "0" }.compact
  end

end
