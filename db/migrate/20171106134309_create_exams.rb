class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.string :name
      t.integer :type
      t.string :exercises
      t.integer :estimated_time

      t.timestamps
    end
  end
end
