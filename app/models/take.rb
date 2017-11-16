class Take < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  def time_used_as_string
    "#{self.time_used / 60}:#{self.time_used % 60}"
  end

  def anwser_results
    exercises = self.exam.exercises.split(',')
    anwsers = self.anwsers.split(',')
    results = []
    exercises.each_with_index do |id, index|
      exercise = Exercise.find(id)
      results.push(exercise.anwser.to_i == anwsers[index].to_i)
    end
    results
  end
end
