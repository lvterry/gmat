class ExamsController < ApplicationController
  layout 'exam', only: [:show, :instructions, :exercise, :pause]

  def index
  end

  def show
    @exam_id = params[:id]
  end

  def instructions
    @exam = Exam.find params[:id]
    @page_id = params[:page_id] || 0
    render 'exams/instructions'
  end

  def exercise
    @exam = Exam.find params[:id]
    @exercise = Exercise.find params[:exercise_id]
    render 'exams/exercise'
  end
end
