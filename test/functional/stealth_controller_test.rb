require File.dirname(__FILE__) + '/../test_helper'

class StealthControllerTest < ActionController::TestCase
  fixtures :projects, :news, :users, :email_addresses, :members

  def setup
    @user                 = User.find(1)
    @user.stealth_allowed = true
    @user.save!
    @request.session[:user_id] = @user.id
  end

  def test_activate_stealth_mode
    post :toggle, toggle: true
    assert_response :success
    @user.reload
    assert @user.stealth_mode_active?
  end

  def test_deactivate_stealth_mode
    @user.activate_stealth_mode
    post :toggle, toggle: true
    assert_response :success
    @user.reload
    refute @user.stealth_mode_active?
  end

  def test_toggle_on_stealth_mode
    @user.deactivate_stealth_mode
    post :toggle
    assert_response :success
    @user.reload
    assert @user.stealth_mode_active?
  end

  def test_toggle_off_stealth_mode
    @user.activate_stealth_mode
    post :toggle
    assert_response :success
    @user.reload
    refute @user.stealth_mode_active?
  end
end
