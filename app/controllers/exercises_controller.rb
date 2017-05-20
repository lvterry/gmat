class ExercisesController < ApplicationController
  before_action :set_labels

  def index
    @exercises = Exercise.all
    @count = Exercise.count
  end

  def show
    @exercise = Exercise.find params[:id]
  end

  def search
    @labels = params[:labels].split(",") if params[:labels].present?

    @exercises = Exercise.search do
      fulltext params[:query]
      with(:label_ids, params[:labels].split(",")) if params[:labels].present?
    end.results

    render :index
  end

  def set_labels
    @difficulties = Label.where(category: '难度')
    @subjects = Label.where(category: '题型')
    @books = Label.where(category: '来源')
  end
end
