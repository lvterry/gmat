class Exam < ApplicationRecord

  has_many :takes
  has_many :users, through: :takes

  def verbal_exercise_ids
    verbal_exercises.nil? ? [] : verbal_exercises.split(',')
  end

  def quant_exercise_ids
    quant_exercises.nil? ? [] : quant_exercises.split(',')
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
