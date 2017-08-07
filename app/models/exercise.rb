class Exercise < ApplicationRecord
  has_and_belongs_to_many :labels

  scope :viewable, -> { where(hide_from_view: false) }

  searchable do
    text :title, :choices

    boolean :exclusive
    boolean :hide_from_view
    integer :label_ids, multiple: true
    integer :seq
  end

  def subjects
    self.label_ids & Label.subject_ids
  end

  def books
    self.label_ids & Label.book_ids
  end

  def difficulties
    self.label_ids & Label.difficulty_ids
  end
end
