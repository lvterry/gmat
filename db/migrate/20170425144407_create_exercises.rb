class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.text :title
      t.text :choices, array: true, default: []
      t.integer :anwser
      t.text :guides, array: true, default: []
      t.string :video_url
      t.text :exercise_tags, array: true, default: []

      t.timestamps
    end
  end
end
