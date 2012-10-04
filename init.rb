require_dependency 'redmine_stealth/redmine_menu_manager_extensions'

if Rails::VERSION::MAJOR >= 3
  require_dependency 'redmne_stealth/stealth_mail_interceptor'
else
  require_dependency 'redmine_stealth/action_mailer_base_extensions'
end

require_dependency 'redmine_stealth/hooks'

require_dependency 'redmine_stealth/application_helper_extensions'

require_dependency 'redmine_stealth/user_extensions'

Redmine::Plugin.register :redmine_stealth do
  name        'Redmine Stealth plugin'
  author      'Riley Lynch'
  description 'Enables users to disable Redmine email notifications ' +
              'for their actions'
  version     '0.5.1'

  if respond_to?(:url)
    url 'http://teleological.github.com/redmine-stealth-plugin'
  end
  if respond_to?(:author_url)
    author_url 'http://github.com/teleological'
  end

  decide_toggle_display =
    lambda do |*_|
      if my_user = User.current
        my_user.stealth_allowed
      else
        false
      end
    end

  stealth_menuitem_captioner =
    lambda { |project| RedmineStealth::Stealth.toggle_stealth_label }

  menu :account_menu, :stealth,
    { :controller => 'stealth', :action => 'toggle' },
    :first    => true,
    :if       => decide_toggle_display,
    :caption  => stealth_menuitem_captioner,
    :html     => {
      :id => RedmineStealth::Stealth::DOMID_STEALTH_TOGGLE,
    }, :remote => true
end
