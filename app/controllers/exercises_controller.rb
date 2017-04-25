class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.all
    @count = Exercise.count
  end

  def show
    @exercise = Exercise.find params[:id]
  end
end
