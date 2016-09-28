class Question < ApplicationRecord
  belongs_to :vip
  validates :q, :a, presence: true
end
