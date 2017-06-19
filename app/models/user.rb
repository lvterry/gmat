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

  def mobile_part
    if self.mobile.present?
      mobile = self.mobile
      mobile[3..6] = '****'
      mobile
    end
  end

  def allowed_labels
    ids = self.user_groups.map do |user_group|
      user_group.label_ids
    end
    ids.flatten
  end

  def is_authorized_to_view?(exercises)
    labels = exercises.label_ids
    allowed_labels = self.allowed_labels
    is_authorized = false
    labels.each do |label|
      if allowed_labels.include?(label)
        is_authorized = true
        break
      end
    end
    is_authorized
  end

end
