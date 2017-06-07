class AddValidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :valid_to, :datetime
  end
end
