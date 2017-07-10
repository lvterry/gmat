class AdminUser < ApplicationRecord
    validates :password, presence: true
    validates :name, presence: true, uniqueness: { case_sensitive: false }

    before_save { self.name = name.downcase }
    has_secure_password
end
