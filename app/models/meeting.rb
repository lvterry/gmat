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
    ['逻辑','语法','数学','阅读','AWA','IR']
  end

  def colors
    ['#266CDE', '#42007D', '#7231A6', '#343534', '#D42D34', '#E4A40B']
  end

end
