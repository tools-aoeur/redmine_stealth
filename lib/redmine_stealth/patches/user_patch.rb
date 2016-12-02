require_dependency 'project'
require_dependency 'user'

module RedmineStealth
  module Patches
    module UserPatch
      def self.prepended(base)
        base.class_eval do
          safe_attributes :stealth_allowed, if: lambda { |_, current_user| current_user.admin? }
        end
      end

      def stealth_mode_active?
        stealth_allowed? && !!pref[:stealth_mode]
      end

      def activate_stealth_mode
        return unless stealth_allowed?
        pref[:stealth_mode] = true
        pref.save!
      end

      def deactivate_stealth_mode
        pref[:stealth_mode] = false
        pref.save!
      end

      def toggle_stealth_mode
        stealth_mode_active? ? deactivate_stealth_mode : activate_stealth_mode
      end
    end
  end
end
