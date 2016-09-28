class AddLongNameToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :long_name, :string
  end
end
