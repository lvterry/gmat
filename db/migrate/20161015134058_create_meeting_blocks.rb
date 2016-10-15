class CreateMeetingBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :meeting_blocks do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :meeting_id

      t.timestamps
    end
  end
end
