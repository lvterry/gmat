class User < ApplicationRecord

  has_and_belongs_to_many :user_groups

  has_many :takes
  has_many :exams, through: :takes

  after_create :add_to_PREP_group

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
      token: auth_hash.credentials.token,
      pinyin: Pinyin.t(auth_hash.info.nickname).gsub(' ','')
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
    label_id = nil

    unless (self.allowed_camp_ids & exercise.camps).blank?
      label_id = (self.allowed_camp_ids & exercise.camps).first
    end

    unless (self.allowed_subject_ids & exercise.subjects).blank?
      label_id = (self.allowed_subject_ids & exercise.subjects).first
    end

    unless (self.allowed_book_ids & exercise.books).blank?
      label_id = (self.allowed_book_ids & exercise.books).first
    end

    if label_id.nil?
      return Permission.NO_PERMISSION
    else
      groups = self.user_groups.map do |group|
        group.label_ids.include?(label_id) ? group : nil
      end

      groups.compact!

      permissions = groups.map do |group|
        Permission.where(user_group_id: group.id, label_id: label_id).first.permission_type
      end

      return permissions.max
    end
  end

  def allow_exam?(exam)
    allow_label_ary = Label.find(self.allowed_exam_ids).map(&:name)
    allow_label_ary.include?(exam.exam_type_label)
  end

  def allowed_exam_ids
    self.allowed_labels & Label.exam_ids
  end

  def allowed_subject_ids
    self.allowed_labels & Label.subject_ids
  end

  def allowed_book_ids
    self.allowed_labels & Label.book_ids
  end

  def allowed_camp_ids
    self.allowed_labels & Label.camp_ids
  end

  def user_groups_as_text
    self.user_groups.map do |group|
      group.name
    end.join(', ')
  end

  private
  def add_to_PREP_group
    if self.provider == "open_wechat"
      group = UserGroup.find_by_name('PREP')
      self.user_groups << group if group.present?
    end
  end

end
