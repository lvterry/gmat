class Exercise < ApplicationRecord
  searchable do
    text :title, :choices
  end
end
