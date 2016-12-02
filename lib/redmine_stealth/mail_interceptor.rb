module RedmineStealth
  class MailInterceptor
    def self.delivering_email(msg)
      if User.current.stealth_mode_active?
        msg.perform_deliveries = false
        if logger = ActionMailer::Base.logger
          logger.info("Squelching notification: #{msg.subject}")
        end
      end
    end
  end
end

ActionMailer::Base.register_interceptor(RedmineStealth::MailInterceptor)
