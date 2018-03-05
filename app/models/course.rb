class Course < ApplicationRecord
  belongs_to :teacher

  def self.subjects
    ['数学','逻辑','语法','阅读','机经','线下', '入门']
  end

  def subject_name
    Course.subjects[self.subject]
  end
end
