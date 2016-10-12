class PostsController < ApplicationController
  def index
    @tags = Tag.all
    @category = params[:category]
    if @category == "" || @category.nil?
      @posts = Post.order(top: :desc, created_at: :desc).page(params[:page]).per_page(10)
    else
      @posts = Post.where("tags LIKE '%#{@category}%'").order(top: :desc, created_at: :desc).page(params[:page]).per_page(10)
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
