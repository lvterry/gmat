class Take < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  def verbal_anwser_results
    anwser_results self.exam.verbal_exercises, self.verbal_anwsers
  end

  def quant_anwser_results
    anwsers = self.quant_anwsers.nil? ? [] : self.quant_anwsers
    exercises = self.quant_exercises.nil? [] : self.quant_exercises
    anwser_results exercises, anwsers
  end

  def verbal_times
    time_points_from_time_series(self.verbal_time_series)
  end

  def quant_times
    if self.exam.exam_type_label == '770'
      time_points_from_time_series(self.quant_time_series)
    end
  end

  def avg_verbal_time
    avg_time self.verbal_times
  end

  def avg_quant_time
    avg_time self.quant_times
  end

  def avg_quant_time
    avg_time self.quant_times
  end

  def verbal_time_management_data
    [3, 6, 5, self.avg_verbal_time]
  end

  def quant_time_management_data
    [3, 6, 5, self.avg_quant_time]
  end

  def verbal_wrong_data
    total = self.verbal_anwser_results.select { |item| item == false }.count
    [11, 19, 2, total]
  end

  def verbal_right_data
    total = self.verbal_anwser_results.select { |item| item == true }.count
    [12, 17, 19, total]
  end

  def quant_wrong_data
    total = self.quant_anwser_results.select { |item| item == false }.count
    [11, 19, 2, total]
  end

  def quant_right_data
    total = self.quant_anwser_results.select { |item| item == true }.count
    [12, 17, 19, total]
  end

  private

    def time_points_from_time_series(time_series)
      times = []
      time_series_arr = time_series.split(',')
      time_series_arr.each_with_index do |point, index|
        if index > 0
          milliseconds = point.to_i - time_series_arr[index - 1].to_i
          seconds = milliseconds / 1000
          times.push(seconds)
        end
      end
      times
    end

    def avg_time(times)
      sum = times.reduce(:+)
      sum.to_f / times.count
    end


    def anwser_results(exercises, anwsers)
      results = []
      exercises.split(',').each_with_index do |id, index|
        exercise = Exercise.find(id)
        results.push(exercise.anwser.to_i == anwsers[index].to_i)
      end
      results
    end
end
