
require_dependency 'action_mailer'
module RedmineStealth
  module Patches
    module ActionMailerOverride
      def deliver_later(options={})
        if User.current.stealth_mode_active?
          if Rails.logger
            Rails.logger.info("Squelching notification: '#{message.subject}' from #{User.current.login} in deliver_later")
          end
        else
          super(options)
        end
      end

      def deliver_now
        if User.current.stealth_mode_active?
          if Rails.logger
            Rails.logger.info("Squelching notification: '#{message.subject}' from #{User.current.login} in deliver_now")
          end
        else
          super
        end
      end
    end
  end
end

module ActionMailer
  class MessageDelivery
    prepend RedmineStealth::Patches::ActionMailerOverride
  end
end
