class Exam < ApplicationRecord

  has_many :takes
  has_many :users, through: :takes

  def exercise_ids
    self.exercises.split(',')
  end

  def exam_type_label
    case self.exam_type
    when 1
      'GWD'
    when 2
      '770'
    else
      'nothing'
    end
  end
end
