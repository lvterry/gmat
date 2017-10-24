module UserHelper
  def add_groups_to_user(user, mobile)
    temp_users = TempUser.where(mobile: mobile)
    temp_users.each do |temp_user|
      unless user.user_group_ids.include?(temp_user.user_group_id)
        user.user_groups << UserGroup.find(temp_user.user_group_id)
      end
      temp_user.destroy
    end
  end
end