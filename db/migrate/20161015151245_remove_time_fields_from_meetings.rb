class RemoveTimeFieldsFromMeetings < ActiveRecord::Migration[5.0]
  def change
    remove_column :meetings, :start_time, :datetime
    remove_column :meetings, :end_time, :datetime
  end
end
