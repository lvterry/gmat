class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.belongs_to :user_group, index: true
      t.belongs_to :label, index: true
      t.integer :permission_type, default: 1
      t.timestamps
    end
  end
end
