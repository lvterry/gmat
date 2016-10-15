class Admin::MeetingsController < AdminController

  def index
    @meetings = Meeting.order(created_at: :desc)
  end

  def new
    @meeting = Meeting.new
    @meeting.meeting_blocks.build
  end

  # def create
  #   @meeting = Meeting.new(meeting_params)
  #   if @meeting.save
  #     flash[:notice] = '保存成功'
  #     redirect_to edit_admin_meeting_path(@meeting)
  #   else
  #     redirect_to new_admin_meeting_path
  #   end
  # end

  def create
    @meeting = Meeting.new(name: meeting_params[:name], link: meeting_params[:link], category: meeting_params[:category])
    if @meeting.save
      blocks = meeting_params[:meeting_blocks_attributes].to_h
      ary = []
      blocks = blocks.each_value do |b|
        ary << MeetingBlock.new(start_time: b[:start_time], end_time: b[:end_time])
      end
      @meeting.meeting_blocks = ary
      flash[:notice] = '保存成功'
      redirect_to edit_admin_meeting_path(@meeting)
    else
      redirect_to new_admin_meeting_path
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      flash[:notice] = '保存成功'
    else
      flash[:notice] = '保存失败'
    end

    redirect_to edit_admin_meeting_path(@meeting)
  end

  def destroy
    Meeting.destroy(params[:id])
    render json: { success: 1 }
  end

  private

  def meeting_params
    params.require(:meeting)
      .permit(:name, :link, :category, meeting_blocks_attributes: [:id, :start_time, :end_time, "_destroy"])
  end
end
