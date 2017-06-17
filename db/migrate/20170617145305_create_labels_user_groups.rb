class CreateLabelsUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :labels_user_groups do |t|
      t.belongs_to :label, index: true
      t.belongs_to :user_group, index: true
    end
  end
end
