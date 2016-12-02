require File.dirname(__FILE__) + '/../test_helper'

class ApplicationHelperPatchTest < ActionController::TestCase
  tests WelcomeController

  fixtures :projects, :news, :users, :email_addresses, :members

  def test_body_css_stealth_off_for_anonymous
    User.current = nil
    @request.session[:user_id] = nil
    get :index
    assert_select 'body.stealth_off'
  end

  def test_body_css_stealth_on_for_admin
    user = User.find(1)
    user.update_attribute :stealth_allowed, true
    user.activate_stealth_mode
    User.current = user
    @request.session[:user_id] = 1
    get :index
    assert_select 'body.stealth_on'
  end
end