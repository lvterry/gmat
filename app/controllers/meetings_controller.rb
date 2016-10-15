class MeetingsController < ApplicationController
  def index
    if params[:category] && params[:category] != "-1"
      @meetings = Meeting.where(category: params[:category])
    else
      @meetings = Meeting.all
    end

    ary = []

    @meetings.each do |m|
      ary += m.as_separate_meetings
    end

    respond_to do |format|
      format.json { render json: ary }
    end
  end
end
