class Admin::LabelsController < AdminController

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    @label.update(label_params)

    redirect_back fallback_location: admin_exercises_path, notice: '保存成功'
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      flash[:notice] = "保存成功"
    else
      flash[:notice] = '保存失败'
    end
    redirect_to edit_admin_label_path(@label)
  end

  # def destroy
  #   @exercise = Exercise.find(params[:id])
  #   @exercise.destroy
  #   redirect_to admin_exercises_path
  # end

  private

  def label_params
    params.require(:label).permit(:name, :category)
  end

end
