class ChangeCourseDescriptionLimit < ActiveRecord::Migration[5.0]
  def change
    change_column :courses, :description, :text, limit: 1048576
  end
end
