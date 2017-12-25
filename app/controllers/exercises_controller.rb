class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.viewable.order(:seq).page(params[:page]).per_page(10)
    @total = Exercise.viewable.count
  end

  def show
    @exercise = Exercise.find params[:id]
    @seq = @exercise.seq.blank? ? 0 : @exercise.seq
    @prev = Exercise.find_by_seq(@seq - 1) ? Exercise.find_by_seq(@seq - 1).id : -1
    @next = Exercise.find_by_seq(@seq + 1) ? Exercise.find_by_seq(@seq + 1).id : -1

    @user_anwser = nil
    if params[:take_id]
      anwser_index = params[:anwser_index].to_i
      @user_anwser = Take.find(params[:take_id]).verbal_anwsers.split(',')[anwser_index]
    end

    respond_to do |format|
      format.html
      format.js { render "show.js.erb" }
    end
  end

  def search
    @labels = params[:labels].split(",") if params[:labels].present?
    @exclusive = params[:exclusive]

    search = Exercise.search do
      fulltext params[:query]
      with(:hide_from_view, false)
      with(:exclusive, true) if params[:exclusive].present?
      with(:label_ids).all_of(params[:labels].split(",")) if params[:labels].present?
      order_by(:seq)
      paginate page: params[:page] || 1, per_page: 10
    end

    @exercises = search.results
    @total = search.total
    render :index
  end

end
