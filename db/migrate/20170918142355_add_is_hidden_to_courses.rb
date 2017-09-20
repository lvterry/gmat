class AddIsHiddenToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :is_hidden, :boolean, default: false
  end
end
