class AddHideFromViewToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :hide_from_view, :boolean, default: false
  end
end
