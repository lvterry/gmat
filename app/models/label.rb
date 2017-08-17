class Label < ApplicationRecord
  has_and_belongs_to_many :exercises
  has_many :permissions
  has_many :user_groups, through: :permissions

  class << self; attr_accessor :difficulties, :subjects, :books, :camps end

  @difficulties = Label.where(category: '难度').order(:updated_at)
  @subjects = Label.where(category: '题型').order(:updated_at)
  @books = Label.where(category: '来源').order(:updated_at)
  @camps = Label.where(category: '训练营').order(:updated_at)

  def self.subject_ids
    @subjects.map { |s| s.id }
  end

  def self.book_ids
    @books.map { |s| s.id }
  end

  def self.difficulty_ids
    @difficulties.map { |s| s.id }
  end

  def self.camp_ids
    @camps.map { |s| s.id }
  end
end
