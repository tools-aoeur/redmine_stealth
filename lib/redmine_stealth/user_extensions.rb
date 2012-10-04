require_dependency 'principal'

module RedmineStealth
  module UserExtensions
    def self.included(base)
      base.class_eval do
        safe_attributes :stealth_allowed,
          :if => lambda { |user, current_user| current_user.admin? }
      end
    end
  end
end

User.send(:include, RedmineStealth::UserExtensions)
