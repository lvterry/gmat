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

  def times
    times = []
    time_series_arr = self.time_series.split(',')
    time_series_arr.each_with_index do |point, index|
      times.push(point.to_i - time_series_arr[index - 1].to_i) if index > 0
    end
    times
  end
end
