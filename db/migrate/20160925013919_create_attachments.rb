class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :orignal_name
      t.string :new_name
      t.integer :size
      t.string :type
      t.string :url
      t.integer :post_id

      t.timestamps
    end
  end
end
