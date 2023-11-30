require_dependency 'project'
require_dependency 'user'

module RedmineStealth
  module Patches
    module UserPatch
      def self.prepended(base)
        base.class_eval do
          safe_attributes :stealth_allowed, if: lambda { |_, current_user|
            current_user.admin? || current_user.stealth_mode_permission? || current_user.stealth_allowed?
          }
        end
      end

      def stealth_mode_permission?
        User.current.allowed_to?({ controller: 'stealth', action: 'toggle' }, nil, global: true)
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

RedmineStealth.prepend_patch RedmineStealth::Patches::UserPatch, User
