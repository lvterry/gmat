class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all

    respond_to do |format|
      format.json { render json: @meetings}
    end
  end
end
