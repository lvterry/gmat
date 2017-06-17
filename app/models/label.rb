class Label < ApplicationRecord
  has_and_belongs_to_many :exercises
  has_and_belongs_to_many :user_groups
end
