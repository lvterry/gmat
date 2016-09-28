class CreateSlides < ActiveRecord::Migration[5.0]
  def change
    create_table :slides do |t|
      t.string :img_url
      t.string :link
      t.string :bg_color

      t.timestamps
    end
  end
end
