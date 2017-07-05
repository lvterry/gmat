class Label < ApplicationRecord
  has_and_belongs_to_many :exercises
  has_and_belongs_to_many :user_groups

  class << self; attr_accessor :difficulties, :subjects, :books end

  @difficulties = Label.where(category: '难度')
  @subjects = Label.where(category: '题型')
  @books = Label.where(category: '来源')
end
