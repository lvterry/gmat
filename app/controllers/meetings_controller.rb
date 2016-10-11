class MeetingsController < ApplicationController
  def index
    if params[:category] && params[:category] != "-1"
      @meetings = Meeting.where(category: params[:category])
    else
      @meetings = Meeting.all
    end

    respond_to do |format|
      format.json { render json: @meetings}
    end
  end
end
