class Exercise < ApplicationRecord
  has_and_belongs_to_many :labels

  searchable do
    text :title, :choices

    boolean :exclusive
    integer :label_ids, multiple: true
  end

  def is_math?
    ps_label_id = 10
    ds_label_id = 19
    self.label_ids.include?(ps_label_id) || self.label_ids.include?(ds_label_id)
  end
end
