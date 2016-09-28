class Vip < ApplicationRecord
  has_many :questions
  has_many :flows
end
