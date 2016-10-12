class CoursesController < ApplicationController
  def index
    @subject = params[:subject]
    if @subject == "" || @subject.nil?
      where_conditions = 'fee > 0'
    else
      where_conditions = "fee > 0 and subject = '#{@subject}'"
    end
    @courses = Course.where(where_conditions).order(seq: :desc, created_at: :desc).page(params[:page]).per_page(7)
  end

  def free
    @archive = false
    get_courses(@archive)
  end

  def free_archive
    @archive = true
    get_courses(@archive)
    render "courses/free"
  end

  def show
    @course = Course.find(params[:id])
    @from = params[:from]
  end

  private
    def get_courses(archive)
      @subject = params[:subject]

      if @subject == "" || @subject.nil?
        where_conditions = { fee: nil }
      else
        where_conditions = { subject: @subject, fee: nil }
      end

      if archive
        where_conditions.merge!(start_time: (DateTime.now - 100.years..DateTime.now))
      else
        where_conditions.merge!(start_time: (DateTime.now..DateTime.now + 100.years))
      end

      @courses = Course.where(where_conditions).order(seq: :desc, created_at: :desc).page(params[:page]).per_page(7)
    end
end
