class CreateFlows < ActiveRecord::Migration[5.0]
  def change
    create_table :flows do |t|
      t.belongs_to :vip, index: true
      t.string :title
      t.text :body
      t.string :img

      t.timestamps
    end
  end
end
