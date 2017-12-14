class ExamsController < ApplicationController
  layout 'exam', only: [:show, :instructions, :exercise, :pause]

  def index
    @exams = Exam.all
  end

  def show
    @exam = Exam.find params[:id]
    @take = Take.new
    if @exam.exam_type == 1
      render 'exams/show'
    else
      @take.exam = @exam
      @take.user = current_user
      @take.save
      @page_id = 1
      render 'exams/instructions'
    end
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
    if @exam.exercises.split(',').index(params[:exercise_id]) == 0
      @take.update(time_series: (Time.now.to_f * 1000).to_i.to_s)
    end
    render 'exams/exercise'
  end

  def result
    @exam = Exam.find params[:id]
    @take = @exam.takes.where(user_id: current_user.id).last
    @exercises = Exercise.find @exam.exercises.split(',')
    @exercise = @exercises.first
  end
end
