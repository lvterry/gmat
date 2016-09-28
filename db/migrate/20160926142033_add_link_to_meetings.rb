class AddLinkToMeetings < ActiveRecord::Migration[5.0]
  def change
    add_column :meetings, :link, :string
  end
end
