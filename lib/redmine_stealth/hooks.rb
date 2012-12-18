
module RedmineStealth
  class Hooks < Redmine::Hook::ViewListener

    def controller_account_success_authentication_after(context={})
      ::RedmineStealth.decloak!
    end

    def view_layouts_base_html_head(context={})
      stylesheet_link_tag('stealth', :plugin => 'redmine_stealth') +
      javascript_include_tag('stealth.js',
                             :plugin => 'redmine-stealth-plugin')
    end

    def view_layouts_base_body_bottom(context={})
      is_cloaked = RedmineStealth.cloaked?
      init_state = RedmineStealth.javascript_toggle_statement(is_cloaked)

      if RedmineStealth::USE_UJS
        js_lib = 'stealth'
        javascript_include_tag(js_lib, :plugin => 'redmine_stealth') +
            javascript_tag("jQuery(function($) { #{init_state} });")
      else
        js_lib = 'prototype-stealth'
        javascript_include_tag(js_lib, :plugin => 'redmine_stealth') +
            javascript_tag(%Q{
            document.observe("dom:loaded", function() { #{init_state} });
          })
      end
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

