class CreateExercisesAndLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises_labels, id: false do |t|
      t.belongs_to :exercise, index: true
      t.belongs_to :label, index: true
    end
  end
end
