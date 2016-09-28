class Admin::SlidesController < AdminController

  def index
    @slides = Slide.all
  end

  def new
    @slide = Slide.new
  end

  def create
    @slide = Slide.create(slide_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_slide_path(@slide)
  end

  def edit
    @slide = Slide.find(params[:id])
  end

  def update
    @slide = Slide.find(params[:id])
    @slide.update(slide_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_slide_path(@slide)
  end

  def destroy
    Slide.destroy(params[:id])
    render json: { success: 1 }
  end

  private

  def slide_params
    params.require(:slide).permit(:img_url, :link, :bg_color)
  end
end
