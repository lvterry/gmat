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

  def is_rc
    !self.labels.find_by_category('题型').nil? && (self.labels.find_by_category('题型').name == '阅读RC')
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

  def camps
    self.label_ids & Label.camp_ids
  end

  def empty_choices?
    return (choices[0] == '') && (choices[1] == '') && (choices[2] == '') && (choices[3] == '') && (choices[4] == '')
  end
end
