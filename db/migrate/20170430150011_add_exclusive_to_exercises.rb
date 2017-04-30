class AddExclusiveToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :exclusive, :boolean, default: true
  end
end
