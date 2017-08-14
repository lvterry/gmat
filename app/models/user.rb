class User < ApplicationRecord

  has_and_belongs_to_many :user_groups

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      uid: auth_hash.uid,
      openid: auth_hash.info.openid,
      nickname: auth_hash.info.nickname,
      sex: auth_hash.info.sex,
      language: auth_hash.info.language,
      city: auth_hash.info.city,
      province: auth_hash.info.province,
      country: auth_hash.info.country,
      headimgurl: auth_hash.info.headimgurl,
      unionid: auth_hash.info.unionid,
      provider: auth_hash.provider,
      token: auth_hash.credentials.token
    )
    user
  end

  def allowed_labels
    ids = self.user_groups.map do |user_group|
      user_group.label_ids if user_group.is_valid?
    end
    ids.flatten.compact
  end

  def permission_type(exercise)
    if (self.allowed_subject_ids & exercise.subjects).blank?
      return Permission.NO_PERMISSION
    else
      labels = self.allowed_subject_ids & exercise.subjects
      label_id = labels[0]

      groups = self.user_groups.map do |group|
        group.label_ids.include?(label_id) ? group : nil
      end

      groups.compact!
      return Permission.where(user_group_id: groups[0].id, label_id: label_id).first.permission_type
    end

    if (self.allowed_book_ids & exercise.books).blank?
      return Permission.NO_PERMISSION
    end

    Permission.TEXT_VIDEO
  end

  def allowed_subject_ids
    self.allowed_labels & Label.subject_ids
  end

  def allowed_book_ids
    self.allowed_labels & Label.book_ids
  end

  def user_groups_as_text
    self.user_groups.map do |group|
      group.name
    end.join(', ')
  end

end
