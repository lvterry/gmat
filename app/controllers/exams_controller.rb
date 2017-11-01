class ExamsController < ApplicationController
  layout 'exam', only: [:show, :instructions, :exercise]

  def index
  end

  def show

  end

  def instructions
    @page_id = params[:page_id] || 0
    render 'exams/instructions'
  end

  def exercise
    @exercise = Exercise.find params[:exercise_id]
    render 'exams/exercise'
  end
end
