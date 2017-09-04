module Admin::ExercisesHelper
  def make_options(labels)
    labels.map { |label| [label.name, label.id] }
  end
end
