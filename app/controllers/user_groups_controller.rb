class UserGroupsController < ApplicationController
  layout 'mobile'

  def join
    @page_title = '加入用户组'
    @group = UserGroup.find params[:id]
    @temp_user = TempUser.new
    render 'join'
  end
end
