class MeetingsController < ApplicationController
  def index
    rangeStart = params[:start]
    rangeEnd = params[:end]

    if (rangeStart.nil? || rangeEnd.nil?)
      @meetings = Meeting.all
    else
      @meetings = Meeting.where("start_time >= '#{rangeStart}' and start_time <= '#{rangeEnd}'")
    end

    respond_to do |format|
      #format.html
      format.json { render json: @meetings}
    end
  end
end
