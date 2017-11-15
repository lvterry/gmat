class TakesController < ApplicationController

  def create
    @take = Take.create take_params
    redirect_to "/exams/#{take_params[:exam_id]}/instructions/1"
  end

  def update
    @take = Take.find params[:id]
    @take.time_used = params[:timeUsed]
    if @take.anwsers.nil?
      @take.anwsers = params[:thisAnwser]
    else
      @take.anwsers = @take.anwsers + ",#{params[:thisAnwser]}"
    end
    @take.save
    render text: "ok"
  end

  private

  def take_params
    params.require(:take).permit(:subjects, :seq, :exam_id, :user_id, :time_used)
  end
end
