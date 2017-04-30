class ExercisesController < ApplicationController
  before_action :set_labels

  def index
    @exercises = Exercise.all
    @count = Exercise.count
  end

  def show
    @exercise = Exercise.find params[:id]
  end

  def set_labels
    @difficulties = ['500-600', '600-700', '700-750', '750+']
    @subjects = ['语法SC', '逻辑CR', '阅读RC', '数学PS', '数学DS', '作文AWA', '推理IR']
    @books = ['OG12', 'OG15', 'OG16', 'OG17', 'Prep07', 'Manhattan']
  end
end
