Rails.logger.info 'Starting Redmine Stealth plugin for RedMine'

Redmine::Plugin.register :redmine_stealth do
  name        'Stealth Plugin'
  author      'Riley Lynch, Restream, Jérôme BATAILLE'
  description 'Enables users to disable Redmine email notifications for their actions'
  version     '1.0.2'
  url         'https://github.com/tools-aoeur/redmine_stealth'
  author_url  'https://github.com/tools-aoeur'

  permission :toggle_stealth_mode, stealth: :toggle

  menu :account_menu, :stealth, { controller: 'stealth', action: 'toggle' }, {
    first: true,
    if: ->(_) {
      User.current.stealth_allowed?
    },
    caption: ->(_) {
      RedmineStealth.status_label(User.current.stealth_mode_active?)
    },
    html: {
      id: 'stealth_toggle',
      remote: true,
      method: :post
    }
  }
end

# see https://www.redmine.org/issues/36245#note-11 and following for changes with zeitwerk autoloading
Rails.application.config.after_initialize do
  require_relative 'lib/redmine_stealth'
  paths = '/lib/redmine_stealth/{patches/*_patch,hooks/*_hook}.rb'
  Dir.glob(File.dirname(__FILE__) + paths).each do |file|
    require_dependency file
  end
end
