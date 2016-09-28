class Post < ApplicationRecord
  validates :title, :body, presence: true

  has_many :attachments

  def tag_names
    Tag.where("id in (#{self.tags})")
  end
end
