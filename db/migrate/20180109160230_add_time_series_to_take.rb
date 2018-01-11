class AddTimeSeriesToTake < ActiveRecord::Migration[5.0]
  def change
    add_column :takes, :time_series, :string
  end
end
