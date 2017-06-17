class CreateUserGroupsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups_users do |t|
      t.belongs_to :user_group, index: true
      t.belongs_to :user, index: true
    end
  end
end
