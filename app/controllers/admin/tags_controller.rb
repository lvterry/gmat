class Admin::TagsController < AdminController

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def new
  end

  def edit
  end

  def create
    if params[:tag][:id] == ""
      Tag.create(tag_params)
    else
      tag = Tag.find(params[:tag][:id])
      tag.update(tag_params)
    end
    redirect_to action: "index"
  end

  def destroy
    tag = Tag.find(params[:id])
    Rails.logger.debug("Found tag: #{tag.attributes.inspect}")
    tag.destroy
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
