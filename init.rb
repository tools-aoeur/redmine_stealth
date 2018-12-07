require 'redmine'

Rails.logger.info 'o=>Starting Redmine Stealth plugin for RedMine'

plugin_name = 'redmine_stealth'

Redmine::Plugin.register plugin_name.to_sym do
  name 'Redmine Stealth Plugin'
  author 'Riley Lynch, Restream'
  description 'Enables users to disable Redmine email notifications ' +
              'for their actions'
  version '0.7.3'
  url 'https://github.com/Restream' + plugin_name
  if respond_to?(:author_url)
    author_url 'http://github.com/teleological'
  end

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

require plugin_name
