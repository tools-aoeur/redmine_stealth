module RedmineStealth
  class ControllerHooks < Redmine::Hook::Listener

    def controller_account_success_authentication_after(context={})
      context[:user].deactivate_stealth_mode
    end

  end
end

