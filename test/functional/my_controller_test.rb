require File.dirname(__FILE__) + '/../test_helper'

class MyControllerTest < ActionController::TestCase
  fixtures :users

  def setup
    @some_user = User.find(:first, :conditions => ["admin = ?", false])
    @admin = User.find(:first, :conditions => ["admin = ?", true])
  end

  def test_admin_can_define_stealth_permission_for_himself
    User.stubs(:current).returns(@admin)

    attributes = @admin.attributes.merge(:stealth_allowed => true)
    post :account, :user => attributes

    assert_response :redirect
    @admin.reload
    assert @admin.stealth_allowed
  end
     
  def test_user_can_not_define_stealth_permission
    User.stubs(:current).returns(@some_user)

    attributes = @some_user.attributes.merge(:stealth_allowed => true)
    post :account, :user => attributes

    assert_response :redirect
    @some_user.reload
    assert !@some_user.stealth_allowed
  end
end
