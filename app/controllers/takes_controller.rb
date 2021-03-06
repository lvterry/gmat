class TakesController < ApplicationController

  def create
    @take = Take.create take_params
    redirect_to "/exams/#{take_params[:exam_id]}/instructions/1?take_id=#{@take.id}"
  end

  def update
    @take = Take.find params[:id]
    #@exam = Exam.find params[:examId]

    #@take.time_used = time_used_in_seconds(@exam.estimated_time, params[:timeLeft])

    if @take.time_series.nil?
      @take.time_series = params[:currentTimestamp]
    else
      @take.time_series += ",#{params[:currentTimestamp]}"
    end

    unless params[:exerciseId].nil?
      @exercise = Exercise.find params[:exerciseId]

      if @exercise.verbal?
        @take.verbal_anwsers.nil? ? @take.verbal_anwsers = params[:thisAnwser] : @take.verbal_anwsers += ",#{params[:thisAnwser]}"
      else
        @take.quant_anwsers.nil? ? @take.quant_anwsers = params[:thisAnwser] : @take.quant_anwsers += ",#{params[:thisAnwser]}"
      end
    end
    
    @take.save
    render plain: "ok"
  end

  private

  def time_used_in_seconds(estimate, cost)
    minutes = cost.split(":")[0].to_i
    seconds = cost.split(":")[1].to_i
    time_cost = minutes * 60 + seconds
    estimate * 60 - time_cost
  end

  def take_params
    params.require(:take).permit(:subjects, :seq, :exam_id, :user_id, :time_used, :verbal_time_series, :quant_time_series)
  end
end
