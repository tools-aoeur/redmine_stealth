require_relative '../test_helper'

class MyControllerTest < ActionController::TestCase
  fixtures :projects, :news, :users, :email_addresses, :members

  def setup
    @some_user = User.find(2)
    @admin     = User.find(1)
  end

  def test_admin_can_define_stealth_permission_for_himself
    User.current = @admin
    @request.session[:user_id] = @admin.id

    attributes = @admin.attributes.merge(stealth_allowed: true)
    post :account, params: { user: attributes }

    assert_response :redirect
    @admin.reload
    assert @admin.stealth_allowed?
  end

  def test_user_can_not_define_stealth_permission
    User.current = @some_user
    @request.session[:user_id] = @some_user.id

    attributes = @some_user.attributes.merge(stealth_allowed: true)
    post :account, params: { user: attributes }

    assert_response :redirect
    @some_user.reload
    assert_not @some_user.stealth_allowed?
  end
end
