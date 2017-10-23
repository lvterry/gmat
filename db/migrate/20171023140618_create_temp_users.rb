class CreateTempUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_users do |t|
      t.integer :user_group_id
      t.string :name
      t.string :mobile

      t.timestamps
    end
  end
end
