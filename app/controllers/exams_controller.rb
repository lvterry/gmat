class ExamsController < ApplicationController
  layout 'exam', only: [:show, :instructions, :exercise, :pause]

  def index
    @exams = Exam.all
  end

  def show
    @exam = Exam.find params[:id]
    @take = Take.new
    if @exam.exam_type_label == '770'
      render 'exams/show'
    else
      @take.exam = @exam
      @take.user = current_user
      @take.subjects = 'V'
      @take.save
      @page_id = 1
      redirect_to "/exams/#{@exam.id}/instructions/1?take_id=#{@take.id}"
    end
  end

  def instructions
    @exam = Exam.find params[:id]
    @page_id = params[:page_id] || 0
    @take = Take.find params[:take_id]
    render 'exams/instructions'
  end

  def exercise
    @exam = Exam.find params[:id]
    @exercise = Exercise.find params[:exercise_id]
    @take = current_user.takes.last
    if @exam.verbal_exercises.split(',').index(params[:exercise_id]) == 0
      @take.update(verbal_time_series: (Time.now.to_f * 1000).to_i.to_s)
    end
    render 'exams/exercise'
  end

  def result
    @exam = Exam.find params[:id]
    @take = Take.find params[:take_id]
    @take.calculate_data
    
    @verbal_exercises = Exercise.find @exam.verbal_exercises.split(',')
    @verbal_times = @take.verbal_times

    if @exam.exam_type_label == '770'
      @quant_exercises = Exercise.find @exam.quant_exercises.split(',')
      @quant_times = @take.quant_times
    end

    @exercise = @verbal_exercises.first
  end

end
