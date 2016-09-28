class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :attachments, :orignal_name, :original_name
  end
end
