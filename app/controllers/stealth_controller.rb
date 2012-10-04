
class StealthController < ApplicationController
  unloadable

  before_filter :check_can_stealth

  def check_can_stealth
    render_403 unless User.current.stealth_allowed
  end

  def toggle
    RedmineStealth::Stealth.toggle_stealth_mode!
    next_toggle_label = RedmineStealth::Stealth.toggle_stealth_label
    toggle_domid      = RedmineStealth::Stealth::DOMID_STEALTH_TOGGLE
    render :update do |page|
      page[toggle_domid].replace_html(next_toggle_label)
    end
  end

end

