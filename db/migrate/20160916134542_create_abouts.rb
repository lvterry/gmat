class CreateAbouts < ActiveRecord::Migration[5.0]
  def change
    create_table :abouts do |t|
      t.string :title
      t.text :body
      t.string :img

      t.timestamps
    end
  end
end
