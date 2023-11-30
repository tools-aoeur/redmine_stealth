require_relative '../test_helper'

class UserPatchTest < ActiveSupport::TestCase
  fixtures :users, :email_addresses

  def test_stealth_mode_always_off_if_not_allowed
    user = User.find(1)
    user.update_attribute :stealth_allowed, true
    user.activate_stealth_mode
    user.update_attribute :stealth_allowed, false
    assert_not user.stealth_mode_active?
  end

  def test_stealth_mode_on_if_allowed
    user = User.find(1)
    user.update_attribute :stealth_allowed, true
    user.activate_stealth_mode
    assert user.stealth_mode_active?
  end
end
