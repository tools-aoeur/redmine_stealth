class StealthController < ApplicationController
  unloadable

  before_filter :check_can_stealth

  def toggle
    toggle_by_params
    render js: RedmineStealth.javascript_toggle_statement(User.current.stealth_mode_active?)
  end

  private

  def toggle_by_params
    case params[:toggle]
      when 'true'
        User.current.activate_stealth_mode
      when 'false'
        User.current.deactivate_stealth_mode
      else
        User.current.toggle_stealth_mode
    end
  end

  def check_can_stealth
    render_403 unless User.current.stealth_allowed?
  end

end

