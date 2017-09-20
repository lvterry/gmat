class CoursesController < ApplicationController
  def index
    @subject = params[:subject]
    if @subject == "" || @subject.nil?
      where_conditions = 'is_hidden = FALSE AND fee > 0'
    else
      where_conditions = "is_hidden = FALSE AND fee > 0 AND subject = '#{@subject}'"
    end
    @courses = Course.where(where_conditions).order(start_time: :desc, created_at: :desc)
  end

  def free
    @subject = params[:subject]
    if @subject == "" || @subject.nil?
      where_conditions = 'is_hidden = FALSE AND (fee IS NULL OR fee = 0)'
    else
      where_conditions = "is_hidden = FALSE AND (fee IS NULL OR fee = 0) AND subject = '#{@subject}'"
    end
    @courses = Course.where(where_conditions).order(start_time: :desc, created_at: :desc)
  end

  def show
    @course = Course.find(params[:id])
    @from = params[:from]
  end

end
