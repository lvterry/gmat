class Meeting < ApplicationRecord
  validates :start_time, :end_time, :name, :link, presence: true

  def as_json(options={})
    {
      id: self.id,
      title: self.name,
      start: self.start_time,
      end: self.end_time,
      url: self.link,
      backgroundColor: self.colors[self.category]
    }
  end

  def categories
    ['数学Q51','数学训练营','逻辑小班','逻辑训练营','语法小班','语法训练营','免费私塾公开课','线下面授班']
  end

  def colors
    ['#266CDE','#266CDE', '#7231A6','#7231A6', '#E4A40B','#E4A40B','#58a128','#00BCD4']
  end

end
