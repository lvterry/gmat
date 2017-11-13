class TakesController < ApplicationController

  def create
    @take = Take.new take_params
    @take.exam_id = params[:id]
    @take.user = current_user
    @take.save

    redirect_to "/exams/#{exam_id}/instructions/1"

  end

  private

  def take_params
    params.require(:take).permit(:subjects, :seq)
  end
end
