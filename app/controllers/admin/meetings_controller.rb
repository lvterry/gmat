class Admin::MeetingsController < AdminController

  def index
    @meetings = Meeting.order(created_at: :desc)
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.create(meeting_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_meeting_path(@meeting)
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    @meeting.update(meeting_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_meeting_path(@meeting)
  end

  def destroy
    Meeting.destroy(params[:id])
    render json: { success: 1 }
  end

  private

  def meeting_params
    params.require(:meeting).permit(:name, :start_time, :end_time, :link, :category)
  end
end
