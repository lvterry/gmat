class TakesController < ApplicationController

  def create
    @take = Take.create take_params
    redirect_to "/exams/#{take_params[:exam_id]}/instructions/1"
  end

  def update
    @take = Take.find params[:id]
    @exam = Exam.find params[:examId]
    @take.time_used = time_used_in_seconds(@exam.estimated_time, params[:timeLeft])
    if @take.anwsers.nil?
      @take.anwsers = params[:thisAnwser]
    else
      @take.anwsers = @take.anwsers + ",#{params[:thisAnwser]}"
    end

    if @take.time_series.nil?
      @take.time_series = params[:currentTimestamp]
    else
      @take.time_series = @take.time_series + ",#{params[:currentTimestamp]}"
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
    params.require(:take).permit(:subjects, :seq, :exam_id, :user_id, :time_used, :time_series)
  end
end
