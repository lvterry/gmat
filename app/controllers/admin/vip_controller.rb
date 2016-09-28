class Admin::VipController < AdminController

  def edit
    @vip = Vip.first
  end

  def update
    @vip = Vip.find(params[:id])
    @vip.update(vip_params)
    flash[:notice] = "保存成功"
    redirect_to edit_admin_vip_path(@vip)
  end

  def flows
    flow = Flow.find(params[:flow][:id])
    flow.update(flow_params)
    redirect_to edit_admin_vip_path(1)
  end

  def questions
    if params[:question][:id] == ""
      vip = Vip.find(params[:vip_id])
      q = vip.questions.new
      q.q = params[:question][:q]
      q.a = params[:question][:a]
      q.save
    else
      q = Question.find(params[:question][:id])
      q.update(question_params)
    end

    redirect_to edit_admin_vip_path(1)
  end

  private

  def vip_params
    params.require(:vip).permit(:f1, :f2, :f3, :f4, :f5, :f6, :f7, :f8)
  end

  def flow_params
    params.require(:flow).permit(:title, :body, :img)
  end

  def question_params
    params.require(:question).permit(:q, :a)
  end
end
