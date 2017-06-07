class CreateUsersAndLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :label, index: true
    end
  end
end
