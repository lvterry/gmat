class ExamsController < ApplicationController
  layout 'exam', only: [:show, :instructions, :exercise, :pause]

  def index
    @exams = Exam.all
  end

  def show
    @exam = Exam.find params[:id]
    @take = Take.new
    if @exam.exam_type_label == 'GWD'
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
    if @exam.verbal_exercises.split(',').index(params[:exercise_id]) == 0
      @take.update(verbal_time_series: (Time.now.to_f * 1000).to_i.to_s)
    end
    render 'exams/exercise'
  end

  def result
    @exam = Exam.find params[:id]
    @take = @exam.takes.where(user_id: current_user.id).last
    #@exercises = Exercise.find @exam.verbal_exercises.split(',')
    
    @verbal_exercises = Exercise.find @exam.verbal_exercises.split(',')
    @quant_exercises = Exercise.find @exam.quant_exercises.split(',')
    @verbal_times = @take.verbal_times
    @math_times = []
    @verbal_right_wrong = []
    @math_right_wrong = []

    results = @take.verbal_anwser_results

    # @exercises.each_with_index do |ex, i|
    #   label = ex.labels.find_by_category('题型')
    #   if ['数学PS', '数学DS'].include?(label.name)
    #     @math_exercises.push ex
    #     @math_times.push times[i]
    #     @math_right_wrong.push results[i]
    #   elsif ['语法SC', '逻辑CR', '阅读RC'].include?(label.name)
    #     @verbal_exercises.push ex
    #     @verbal_times.push times[i]
    #     @verbal_right_wrong.push results[i]
    #   end
    # end
    @exercise = @verbal_exercises.first
  end

  private

  def verbal_exercises(exercises)

  end

  def math_exercises(exercises)

  end
end
