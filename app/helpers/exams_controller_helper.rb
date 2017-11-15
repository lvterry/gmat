module ExamsControllerHelper
  def skip_instructions_url(exam)
    first_exercise_id = exam.exercise_ids.first
    "/exams/#{exam.id}/exercises/#{first_exercise_id}"
  end

  def next_instruction_url(exam, page_id)
    if page_id.to_i == 13
      skip_instructions_url(exam)
    else
      "/exams/#{exam.id}/instructions/#{page_id.to_i + 1}"
    end
  end

  def next_exercise_url(exam, current_exercise)
    index = exam.exercise_ids.index(current_exercise.id.to_s)
    id = current_exercise.id
    if index < (exam.exercise_ids.length - 1)
      id = exam.exercise_ids[index + 1]
    else
      id = -1
    end
    "/exams/#{exam.id}/exercises/#{id}"
  end

  def current_location(exam, current_exercise)
    exam.exercise_ids.index(current_exercise.id.to_s) + 1
  end
end
