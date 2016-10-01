class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :img_url
      t.datetime :start_time
      t.datetime :end_time
      t.integer :subject
      t.integer :fee
      t.string :link
      t.string :video_id
      t.integer :seq

      t.timestamps
    end
  end
end
