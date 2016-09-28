class Admin::PostsController < AdminController
  before_action :get_tags

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.tags = tags_string(params)
    @post.update(post_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_post_path(@post)
  end

  def create
    @post = Post.new(post_params)
    @post.tags = tags_string(params)
    @post.save

    flash[:notice] = "保存成功"

    redirect_to edit_admin_post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  def delete_attachment
    attachment = Attachment.find(params[:attachment_id])
    attachment.destroy
    render json: { success: 1 }
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :top, :tags, :summary)
  end

  def get_tags
    @tags = Tag.all
  end

  def tags_string(params)
    ary = params[:post][:tags]
    ary.nil? ? "" : ary * ','
  end
end
