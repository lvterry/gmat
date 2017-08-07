class Permission < ApplicationRecord
    belongs_to :label
    belongs_to :user_group

    class << self; attr_accessor :NO_PERMISSION, :TEXT, :TEXT_VIDEO end

    @NO_PERMISSION = 0
    @TEXT = 1
    @TEXT_VIDEO = 2
end
