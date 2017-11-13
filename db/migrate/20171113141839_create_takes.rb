class CreateTakes < ActiveRecord::Migration[5.0]
  def change
    create_table :takes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :exam, index: true
      t.datetime :take_date
      t.string :subjects
      t.string :seq
      t.string :anwsers
      t.integer :time_used
      t.timestamps
    end
  end
end
