require 'redmine'

Redmine::Plugin.register :redmine_stealth do

  name 'Redmine Stealth Plugin'
  author 'Riley Lynch, Restream'
  description 'This plugin enables the Redmine administrator to disable email notifications temporarily.'
  version '0.7.0'
  url 'https://github.com/Restream/redmine_stealth'

  permission :toggle_stealth_mode, stealth: :toggle

  menu :account_menu, :stealth, { controller: 'stealth', action: 'toggle' }, {
    first:   true,
    if:      ->(_) {
      User.current.stealth_allowed? &&
        User.current.allowed_to?({ controller: 'stealth', action: 'toggle' }, nil, global: true)
    },
    caption: ->(_) {
      RedmineStealth.status_label(User.current.stealth_mode_active?)
    },
    html:    {
      id:     'stealth_toggle',
      remote: true,
      method: :post
    }
  }

end

require 'redmine_stealth'