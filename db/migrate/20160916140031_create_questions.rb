class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.belongs_to :vip, index: true
      t.string :q
      t.text :a

      t.timestamps
    end
  end
end
