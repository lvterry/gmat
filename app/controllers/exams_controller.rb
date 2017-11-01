class ExamsController < ApplicationController
  layout 'exam', only: [:show, :instructions]

  def index
  end

  def show

  end

  def instructions
    @page_id = params[:page_id] || 0
    render 'exams/instructions'
  end
end
