require_dependency 'application_helper'

module RedmineStealth
  module Patches
    module ApplicationHelperPatch
      def body_css_classes
        super + (User.current.stealth_mode_active? ? ' stealth_on' : ' stealth_off')
      end
    end
  end
end
