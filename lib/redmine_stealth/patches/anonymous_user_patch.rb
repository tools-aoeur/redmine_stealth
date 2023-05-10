require_dependency 'project'
require_dependency 'user'

module RedmineStealth
  module Patches
    module AnonymousUserPatch
      def stealth_mode_permission?
        false
      end

      def stealth_mode_active?
        false
      end

      def stealth_allowed?
        false
      end
    end
  end
end

RedmineStealth.prepend_patch RedmineStealth::Patches::AnonymousUserPatch, AnonymousUser
