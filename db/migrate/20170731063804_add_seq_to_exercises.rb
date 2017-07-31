class AddSeqToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :seq, :integer, default: 0
  end
end
