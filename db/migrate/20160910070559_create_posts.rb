class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body, limit: 1048576
      t.string :tags

      t.timestamps
    end
  end
end
