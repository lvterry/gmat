module Admin::ExercisesHelper
  def make_options(labels)
    labels.map { |label| [label.name, label.id] }
  end
  
  def wechat_avatar_url(url)
    return url.nil? ? "" : url
  end
end
