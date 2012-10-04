module RedmineStealth
  class Hooks < Redmine::Hook::ViewListener
    def controller_account_success_authentication_after(context={})
      # on login decloak
      Stealth.decloak!
    end

    def view_layouts_base_html_head(context={})
      javascript_include_tag 'stealth.js',
        :plugin => 'redmine-stealth-plugin'
    end

    def view_users_form(context={})
      stealth_settings(context)
    end

    def view_my_account(context={})
      stealth_settings(context)
    end

    private
      def stealth_settings(context)
        context[:controller].send(:render_to_string, {
         :partial => "hooks/stealth_settings",
         :locals => context
        })
      end
  end
end
