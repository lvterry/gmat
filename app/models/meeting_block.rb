class MeetingBlock < ApplicationRecord
  validates :start_time, :end_time, presence: true
  belongs_to :meeting
end
