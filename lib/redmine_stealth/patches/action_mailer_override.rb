require_dependency 'action_mailer'

module RedmineStealth
  module Patches
    module ActionMailerOverride
      def deliver_later(options = {})
        return super(options) unless User.current.stealth_mode_active?
        return unless Rails.logger

        Rails.logger.info("Squelching notification: '#{message.subject}' from #{User.current.login} in deliver_later")
      end

      def deliver_now
        return super unless User.current.stealth_mode_active?
        return unless Rails.logger

        Rails.logger.info("Squelching notification: '#{message.subject}' from #{User.current.login} in deliver_now")
      end
    end
  end
end

module ActionMailer
  class MessageDelivery
    prepend RedmineStealth::Patches::ActionMailerOverride
  end
end
