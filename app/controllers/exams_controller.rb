class ExamsController < ApplicationController
  layout 'exam', only: [:show, :instructions, :exercise, :pause]

  def index
    @exams = Exam.all
  end

  def show
    @exam = Exam.find params[:id]
    @take = Take.new
    render "exams/show"
  end

  def instructions
    @exam = Exam.find params[:id]
    @page_id = params[:page_id] || 0
    render 'exams/instructions'
  end

  def exercise
    @exam = Exam.find params[:id]
    @exercise = Exercise.find params[:exercise_id]
    @take = current_user.takes.last
    render 'exams/exercise'
  end

  def result
    @exam = Exam.find params[:id]
    @take = @exam.takes.where(user_id: current_user.id).last
  end
end
