class CoursesController < ApplicationController
  def index
    @subject = params[:subject]
    if @subject == "" || @subject.nil?
      where_conditions = 'fee > 0'
    else
      where_conditions = "fee > 0 and subject = '#{@subject}'"
    end
    @courses = Course.where(where_conditions).order(seq: :desc, created_at: :desc).page(params[:page]).per_page(10)
  end

  def free
    @subject = params[:subject]
    if @subject == "" || @subject.nil?
      where_conditions = 'fee IS NULL OR fee = 0'
    else
      where_conditions = "(fee IS NULL OR fee = 0) and subject = '#{@subject}'"
    end
    @courses = Course.where(where_conditions).order(start_time: :desc, created_at: :desc)
  end

  def show
    @course = Course.find(params[:id])
    @from = params[:from]
  end

end
