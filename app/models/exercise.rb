class Exercise < ApplicationRecord
  has_and_belongs_to_many :labels

  searchable do
    text :title, :choices

    boolean :exclusive
    integer :label_ids, multiple: true
  end
end
