class Take < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  attr_accessor :verbal_right_data, :verbal_wrong_data,
    :verbal_time_management_data, :quant_time_management_data,
    :quant_wrong_data, :quant_right_data, :accuracy_hash

  def verbal_anwser_results
    anwser_results self.exam.verbal_exercises, self.verbal_anwsers
  end

  def quant_anwser_results
    anwser_results self.exam.quant_exercises, self.quant_anwsers
  end

  def verbal_times
    if exam.exam_type_label == 'GWD'
      return time_points_from_time_series
    else
      verbal_count = self.exam.verbal_exercise_ids.count

      if verbal_first?
        return time_points_from_time_series.slice(0, verbal_count)
      else
        len = time_points_from_time_series.count
        return time_points_from_time_series.slice(len - verbal_count, verbal_count)
      end
    end
  end

  def quant_times
    if exam.exam_type_label == 'GWD'
      return []
    else
      quant_count = self.exam.quant_exercise_ids.count

      unless verbal_first?
        return time_points_from_time_series.slice(0, quant_count)
      else
        len = time_points_from_time_series.count
        return time_points_from_time_series.slice(len - quant_count, quant_count)
      end
    end
  end

  def avg_verbal_time
    avg_time(verbal_times)
  end

  def avg_quant_time
    avg_time(quant_times)
  end

  def verbal_first?
    self.seq.index('V') < self.seq.index('Q')
  end

  def calculate_data

    time_ps = []
    time_ds = []
    time_cr = []
    time_rc = []
    time_sc = []

    right_ps = 0
    right_ds = 0
    right_cr = 0
    right_rc = 0
    right_sc = 0

    wrong_ps = 0
    wrong_ds = 0
    wrong_cr = 0
    wrong_rc = 0
    wrong_sc = 0

    exam.verbal_exercise_ids.each_with_index do |id, index|
      e = Exercise.find id
      case e.labels.where(category: '题型').first.name
      when '语法SC'
        time_sc.push verbal_times[index]
        if verbal_anwser_results[index]
          right_sc += 1
        else
          wrong_sc += 1
        end
      when '逻辑CR'
        time_cr.push verbal_times[index]
        if verbal_anwser_results[index]
          right_cr += 1
        else
          wrong_cr += 1
        end
      when '阅读RC'
        time_rc.push verbal_times[index]
        if verbal_anwser_results[index]
          right_rc += 1
        else
          wrong_rc += 1
        end
      else
      end
    end

    #debug

    @verbal_time_management_data = [avg_time(time_rc), avg_time(time_cr), avg_time(time_sc), avg_verbal_time]
    @verbal_right_data = [right_rc, right_cr, right_sc, (right_rc + right_cr + right_sc)]
    @verbal_wrong_data = [wrong_rc, wrong_cr, wrong_sc, (wrong_rc + wrong_cr + wrong_sc)]

    exam.quant_exercise_ids.each_with_index do |id, index|
      e = Exercise.find id
      case e.labels.where(category: '题型').first.name
      when '数学PS'
        time_ps.push quant_times[index]
        if verbal_anwser_results[index]
          right_ps += 1
        else
          wrong_ps += 1
        end
      when '数学DS'
        time_ds.push quant_times[index]
        if verbal_anwser_results[index]
          right_ds += 1
        else
          wrong_ds += 1
        end
      else
      end
    end

    @quant_time_management_data = [avg_time(time_ps), avg_time(time_ds), avg_quant_time]
    @quant_right_data = [right_ps, right_ds, (right_ps + right_ds)]
    @quant_wrong_data = [wrong_ps, wrong_ds, (wrong_ps + wrong_ds)]

    @accuracy_hash = {'语法SC' => right_sc.to_f / (right_sc + wrong_sc).to_f * 100.0,
                     '逻辑CR' => right_cr.to_f / (right_cr + wrong_cr).to_f * 100.0,
                     '阅读RC' => right_rc.to_f / (right_rc + wrong_rc).to_f * 100.0,
                     '数学DS' => right_ds.to_f / (right_ds + wrong_ds).to_f * 100.0,
                     '数学PS' => right_ps.to_f / (right_ps + wrong_ps).to_f * 100.0}


  end

  def calculate_in_group_of_10
    hash = {verbal: [], quant: []}
    self.verbal_anwser_results.in_groups_of(10, false).each_with_index do |group, index|
      false_percent = group.count(false).to_f / 10.to_f * 100.0
      hash[:verbal] << {'incorrect' => false_percent, 'correct' => 100.0 - false_percent, 'count' => group.size}
    end

    self.quant_anwser_results.in_groups_of(10, false).each_with_index do |group, index|
      false_percent = group.count(false).to_f / 10.to_f * 100.0
      hash[:quant] << {'incorrect' => false_percent, 'correct' => 100.0 - false_percent, 'count' => group.size}
    end
    hash.merge(total: self.verbal_anwser_results.count + self.quant_anwser_results.count)
  end


  private

    def time_points_from_time_series
      return [] if self.time_series.blank?
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

    def avg_time(times)
      if times.blank?
        return 0
      else
        begin
          sum = times.reduce(:+)
          sum.to_f / times.count
        rescue
          return 0
        end
      end
    end


    def anwser_results(exercises, anwsers)
      results = []
      unless exercises.nil? || anwsers.nil?
        anwsers = anwsers.split(',')
        exercises.split(',').each_with_index do |id, index|
          exercise = Exercise.find(id)
          results.push(exercise.anwser == anwsers[index].to_i)
        end
      end
      results
    end
end
