class RemoveValidToFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :valid_to, :datetime
  end
end
