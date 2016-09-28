class Admin::AttachmentsController < AdminController

  def create
    Attachment.create(attachment_params)
    render json: { success: 1 }
  end

  def destroy
    Attachment.destroy(params[:id])
    render json: { success: 1 }
  end

  private

  def attachment_params
    params.require(:attachment).permit(:original_name, :new_name, :attachment_type, :size, :url, :post_id)
  end
end
