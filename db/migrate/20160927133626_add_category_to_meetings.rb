class AddCategoryToMeetings < ActiveRecord::Migration[5.0]
  def change
    add_column :meetings, :category, :integer
  end
end
