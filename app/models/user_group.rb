class UserGroup < ApplicationRecord
  has_and_belongs_to_many :users
  #has_and_belongs_to_many :labels
  has_many :permissions
  has_many :labels, through: :permissions

  validates :name, presence: true

  def label_names
    self.labels.map do |label|
      label.name
    end.join ", "
  end

  def is_valid?
    self.valid_to.blank? || (self.valid_to > Time.now)
  end
end
