class Exam < ApplicationRecord
  def exercise_ids
    self.exercises.split(',')
  end
end
