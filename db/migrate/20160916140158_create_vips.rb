class CreateVips < ActiveRecord::Migration[5.0]
  def change
    create_table :vips do |t|
      t.string :f1
      t.string :f2
      t.string :f3
      t.string :f4
      t.string :f5
      t.string :f6
      t.string :f7
      t.string :f8

      t.timestamps
    end
  end
end
