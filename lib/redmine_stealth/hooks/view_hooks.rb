module RedmineStealth
  module Hooks
    class ViewHooks < Redmine::Hook::ViewListener
      render_on :view_users_form, partial: 'hooks/stealth_settings'
      render_on :view_my_account, partial: 'hooks/stealth_settings'

      def view_layouts_base_html_head(_context = {})
        stylesheet_link_tag('stealth', plugin: 'redmine_stealth') +
          javascript_include_tag('stealth.js', plugin: 'redmine_stealth')
      end

      def view_layouts_base_body_bottom(_context = {})
        init_state = RedmineStealth.javascript_toggle_statement(User.current.stealth_mode_active?)

        javascript_include_tag('stealth', plugin: 'redmine_stealth') +
          javascript_tag(<<-JS)
            jQuery(function($) {
              #{init_state}
              RedmineStealth.failureMessage = "#{l(:failed_to_toggle_stealth_mode)}";
            });
          JS
      end
    end
  end
end
