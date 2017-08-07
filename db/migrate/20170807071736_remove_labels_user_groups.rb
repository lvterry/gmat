class RemoveLabelsUserGroups < ActiveRecord::Migration[5.0]
  def change
    drop_table :labels_user_groups
  end
end
