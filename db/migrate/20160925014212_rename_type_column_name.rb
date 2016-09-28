class RenameTypeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :attachments, :type, :attachment_type
  end
end
