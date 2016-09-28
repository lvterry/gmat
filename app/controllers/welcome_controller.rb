class WelcomeController < ApplicationController
  def index
    @slides = Slide.all
    @meetings = Meeting.all
  end

  def about
    @about = About.first
    @teachers = Teacher.all
  end

  def vip
    @vip = Vip.first
  end

  def uptoken
    bucket = 'gmat770-web-static'
    put_policy = Qiniu::Auth::PutPolicy.new(bucket)
    uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    render json: { uptoken: uptoken }
  end
end
