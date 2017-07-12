class Exercise < ApplicationRecord
  has_and_belongs_to_many :labels

  searchable do
    text :title, :choices

    boolean :exclusive
    integer :label_ids, multiple: true
  end

  def is_sc_cr_ps_ds?
    val = false
    Settings.label_ids.each do |label_id|
      val = true if self.label_ids.include?(label_id)
    end
    val
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
