class AddColumnsToTakes < ActiveRecord::Migration[5.0]
  def change
    rename_column :takes, :anwsers, :verbal_anwsers
    rename_column :takes, :time_series, :verbal_time_series
    add_column :takes, :quant_anwsers, :string
    add_column :takes, :quant_time_series, :string
  end
end
