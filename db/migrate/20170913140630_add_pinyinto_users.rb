class AddPinyintoUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pinyin, :string
  end
end
