module PostsHelper
  def tag_checked(post, tag)
    if post.tags.nil?
      ""
    else
      post.tags.split(',').include?(tag.id.to_s) ? 'checked' : ''
    end
  end

  def post_category_url(category_id)
    "/posts?category=#{category_id}"
  end
end
