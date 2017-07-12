require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
  test "user group without valid_to is valid" do
    assert user_groups(:two).is_valid?
  end

  test "user group with future valid_to is valid" do
    assert user_groups(:three).is_valid?
  end

  test "user group with past valid_to is not valid" do
    assert_not user_groups(:one).is_valid?
  end
end
