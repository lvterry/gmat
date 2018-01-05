class Exam < ApplicationRecord

  has_many :takes
  has_many :users, through: :takes

  def verbal_exercise_ids
    verbal_exercises.nil? ? [] : verbal_exercises.split(',')
  end

  def quant_exercise_ids
    quant_exercises.nil? ? [] : quant_exercises.split(',')
  end

  def user_count
    self.users.to_set.count
  end

  def avg_num_of_wrong_verbal_exercises
    num_of_wrong_anwsers = self.takes.map do |t|
      t.verbal_anwser_results.select { |r| r == false }.count
    end
    (num_of_wrong_anwsers.reduce(:+).to_f / self.takes.count).round(1)
  end

  def avg_num_of_wrong_quant_exercises
    num_of_wrong_anwsers = self.takes.map do |t|
      t.quant_anwser_results.select { |r| r == false }.count
    end
    (num_of_wrong_anwsers.reduce(:+).to_f / self.takes.count).round(1)
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
