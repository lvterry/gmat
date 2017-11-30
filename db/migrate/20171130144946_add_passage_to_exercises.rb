class AddPassageToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :passage, :text
  end
end
