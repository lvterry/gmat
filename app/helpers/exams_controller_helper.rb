module ExamsControllerHelper
  def skip_instructions_url(exam, take)
    if exam.exam_type_label == Exam.VERBAL_ONLY
      first_exercise_id = exam.verbal_exercise_ids.first
    elsif exam.exam_type_label == Exam.QUANT_ONLY
      first_exercise_id = exam.quant_exercise_ids.first
    elsif exam.exam_type_label == Exam.VERBAL_QUANT
      if take.subjects == 'V,Q'
        if take.seq.index('V') > take.seq.index('Q')
          first_exercise_id = exam.quant_exercise_ids.first
        else
          first_exercise_id = exam.verbal_exercise_ids.first
        end
      else
        if take.subjects == 'V'
          first_exercise_id = exam.verbal_exercise_ids.first
        else
          first_exercise_id = exam.quant_exercise_ids.first
        end
      end
    end
    
    "/exams/#{exam.id}/exercises/#{first_exercise_id}"
  end

  def skip_break_url(exam, take)    
    if take.seq.index('V') > take.seq.index('Q')
      first_exercise_id = exam.verbal_exercise_ids.first
    else
      first_exercise_id = exam.quant_exercise_ids.first
    end

    "/exams/#{exam.id}/exercises/#{first_exercise_id}"
  end

  def next_instruction_url(exam, page_id, take)
    if page_id.to_i == 13
      skip_instructions_url(exam, take)
    else
      "/exams/#{exam.id}/instructions/#{page_id.to_i + 1}?take_id=#{take.id}"
    end
  end

  def next_exercise_url(exam, current_exercise, take)
    show_break = false
    id = current_exercise.id
    exercise_ids = current_exercise.verbal? ? exam.verbal_exercise_ids : exam.quant_exercise_ids
    idx = exercise_ids.index(current_exercise.id.to_s)
    if idx < (exercise_ids.length - 1)
      id = exercise_ids[idx + 1]
    else
      if take.subjects == 'V,Q'
        if (take.seq.index('V') > take.seq.index('Q')) and current_exercise.quant?
          show_break = true
          id = exam.verbal_exercise_ids.first
        elsif (take.seq.index('V') < take.seq.index('Q')) and current_exercise.verbal?
          show_break = true
          id = exam.quant_exercise_ids.first
        else
          id = -1
        end
      else
        id = -1
      end
    end

    if show_break
      "/exams/#{exam.id}/instructions/14?take_id=#{take.id}"
    else
      "/exams/#{exam.id}/exercises/#{id}"
    end
  end

  def current_location(exam, current_exercise)
    if current_exercise.verbal?
      exam.verbal_exercise_ids.index(current_exercise.id.to_s) + 1
    else
      exam.quant_exercise_ids.index(current_exercise.id.to_s) + 1
    end
  end

  def exercise_number_css_class(i, anwser_results, show)
    classes = ''
    classes = 'current' if (i == 0) and show
    classes += ' wrong' unless anwser_results[i]
    classes
  end

  def total(exam, exercise)
    exercise.verbal? ? exam.verbal_exercise_ids.length : exam.quant_exercise_ids.length
  end
end
