class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :openid
      t.string :nickname
      t.integer :sex
      t.string :language
      t.string :city
      t.string :province
      t.string :country
      t.string :headimgurl
      t.string :unionid

      t.timestamps
    end
  end
end
