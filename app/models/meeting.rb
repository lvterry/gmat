class Meeting < ApplicationRecord
  validates :name, :link, presence: true
  has_many :meeting_blocks, index_errors: true
  accepts_nested_attributes_for :meeting_blocks, allow_destroy: true

  def as_separate_meetings()
    self.meeting_blocks.map do |mb|
      {
        id: self.id,
        title: self.name,
        start: mb.start_time,
        end: mb.end_time,
        url: self.link,
        backgroundColor: self.colors[self.category]
      }
    end
  end

  def categories
    ['Elite∙数学冲刺','数学百题斩','Elite∙逻辑突破','Verbal百题斩–逻辑','Elite∙语法突破','Verbal百题斩–语法','公开课','线下面授班', '限时免费', 'Elite∙阅读提升','挑战700+']
  end

  def colors
    ['#266CDE','#266CDE', '#7231A6','#7231A6', '#E4A40B','#E4A40B','#999','#00BCD4','#999', '#58a128','#999']
  end

end
