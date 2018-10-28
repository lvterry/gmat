class CoursesController < ApplicationController
  def index
    @subject = params[:subject]
    if @subject == "" || @subject.nil?
      where_conditions = 'is_hidden = FALSE AND fee > 0'
    else
      where_conditions = "is_hidden = FALSE AND fee > 0 AND subject = '#{@subject}'"
    end
    @courses = sort(Course.where(where_conditions).order(start_time: :asc).to_a)
  end

  def free
    @subject = params[:subject]
    if @subject == "" || @subject.nil?
      where_conditions = 'is_hidden = FALSE AND (fee IS NULL OR fee = 0)'
    else
      where_conditions = "is_hidden = FALSE AND (fee IS NULL OR fee = 0) AND subject = '#{@subject}'"
    end
    @courses = sort(Course.where(where_conditions).order(start_time: :asc).to_a)
  end

  def show
    @course = Course.find_by_id params[:id]
    if @course.nil?
      render text:'Sorry, we cannot find this course', status: 404
      return
    end

    @from = params[:from]  
  end

  private

  def sort(courses)
    to_start = courses.reject do |item|
      item.start_time < DateTime.now
    end

    ended = courses.reject do |item|
      item.start_time >= DateTime.now
    end

    ended.sort! do |x, y|
      y.end_time <=> x.end_time
    end

    return to_start + ended
  end

end
