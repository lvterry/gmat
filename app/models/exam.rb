class Exam < ApplicationRecord

  has_many :takes
  has_many :users, through: :takes

  class << self; attr_accessor :VERBAL_ONLY, :QUANT_ONLY, :VERBAL_QUANT end

  @VERBAL_ONLY = 1
  @QUANT_ONLY = 2
  @VERBAL_QUANT = 3

  TYPE_GWD = 1
  TYPE_770 = 2

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
    if verbal_exercises.empty? and !quant_exercises.empty?
      return Exam.QUANT_ONLY
    elsif quant_exercises.empty? and !verbal_exercises.empty?
      return Exam.VERBAL_ONLY
    elsif !quant_exercises.empty? and !verbal_exercises.empty?
      return Exam.VERBAL_QUANT
    end
  end

  def exam_type_as_label
    case self.exam_type
    when 1
      'GWD'
    when 2
      '770'
    when 3
      'Prep'  
    else
      'nothing'
    end
  end

end
