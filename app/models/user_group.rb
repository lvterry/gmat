class UserGroup < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :labels

  validate do |group|
    group.errors[:base] << "请填写组名"
  end

  def label_names
    self.labels.map do |label|
      label.name
    end.join ", "
  end
end
