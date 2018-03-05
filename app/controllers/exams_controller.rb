class ExamsController < ApplicationController
  layout 'exam', only: [:show, :instructions, :exercise, :pause]
  before_action :find_exam, except: [:index]
  before_action :check_permission, except: [:index]


  def index
    @top = Exam.find([36, 38])
    @exams_gwd = Exam.where(exam_type: 1).where.not(id: [36, 38])
    @exams_770 = Exam.where(exam_type: 2)
  end

  def show
    @take = Take.new
    if @exam.exam_type_label == Exam.VERBAL_QUANT
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
    @page_id = params[:page_id] || 0
    @take = Take.find params[:take_id]
    render 'exams/instructions'
  end

  def exercise
    @exercise = Exercise.find params[:exercise_id]
    @take = current_user.takes.last
    if @exam.verbal_exercises.split(',').index(params[:exercise_id]) == 0
      @take.update(verbal_time_series: (Time.now.to_f * 1000).to_i.to_s)
    end
    render 'exams/exercise'
  end

  def result
    @take = Take.find params[:take_id]
    @take.calculate_data

    @verbal_exercises = Exercise.find @exam.verbal_exercises.split(',')
    @verbal_times = @take.verbal_times

    if @exam.exam_type_label == Exam.VERBAL_QUANT
      @quant_exercises = Exercise.find @exam.quant_exercises.split(',')
      @quant_times = @take.quant_times
    end

    @exercise = @verbal_exercises.first

    respond_to do |format|
      format.html
      format.json {render json: @take.calculate_in_group_of_10.to_json}
    end
  end

  private

  def find_exam
    @exam = Exam.find params[:id]
  end

  def check_permission
    if current_user.blank? || !current_user.allow_exam?(@exam)
      flash[:error] = "您没有权限查看这个模考"
      redirect_to exams_path
      return false
    end
  end

end
