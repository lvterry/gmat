class Post < ApplicationRecord
  validates :title, :body, presence: true

  has_many :attachments

  def tag_names
    if self.tags == ""
      []
    else
      Tag.where("id in (#{self.tags})")
    end
  end
end
