require 'redmine'

Rails.logger.info 'Starting Redmine Stealth plugin for RedMine'

Redmine::Plugin.register :redmine_stealth do
  name        'Stealth Plugin'
  author      'Riley Lynch, Restream, Jérôme BATAILLE'
  description 'Enables users to disable Redmine email notifications for their actions'
  version     '1.0.1'
  url         'https://github.com/tools-aoeur/redmine_stealth'
  author_url  'https://github.com/tools-aoeur'


  permission :toggle_stealth_mode, stealth: :toggle

  menu :account_menu, :stealth, { controller: 'stealth', action: 'toggle' }, {
    first:   true,
    if:      ->(_) {
      User.current.stealth_allowed?
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
