class Take < ApplicationRecord
  belongs_to :exam
  belongs_to :user

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
      if index > 0
        milliseconds = point.to_i - time_series_arr[index - 1].to_i
        seconds = milliseconds / 1000
        times.push(seconds)
      end
    end
    times
  end

  def avg_time
    sum = self.times.reduce(:+)
    sum / (self.times.count - 1)
  end

  def time_management_data
    [3, 6, 5, self.avg_time]
  end

  def wrong_data
    total = self.anwser_results.select { |item| item == false }.count
    [11, 19, 2, total]
  end

  def right_data
    total = self.anwser_results.select { |item| item == true }.count
    [12, 17, 19, total]
  end
end
