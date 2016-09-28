class Admin::AboutController < AdminController

  def edit
    @about = About.first
  end

  def update
    @about = About.find(params[:id])
    @about.update(about_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_about_path(@about)
  end

  private

  def about_params
    params.require(:about).permit(:title, :body, :img)
  end
end
