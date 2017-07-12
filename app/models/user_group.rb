class UserGroup < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :labels

  validates :name, presence: true

  # validate do |group|
  #   group.errors[:base] << "请填写组名"
  # end

  def label_names
    self.labels.map do |label|
      label.name
    end.join ", "
  end

  def is_valid?
    self.valid_to.blank? || (self.valid_to > Time.now)
  end
end
