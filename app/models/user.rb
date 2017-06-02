class User < ApplicationRecord

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
end
