class AddAvatarToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :avatar, :string
  end
end
