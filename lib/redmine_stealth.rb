module RedmineStealth

  include Redmine::I18n

  module_function

  def status_label(is_activateed)
    is_activateed ? l(:disable_stealth_mode) : l(:enable_stealth_mode)
  end

  def javascript_toggle_statement(is_activateed)
    label  = status_label(is_activateed)
    method = "RedmineStealth.#{ is_activateed ? 'activate' : 'deactivate' }"
    "#{method}('#{label}');"
  end

  def prepend_patch(patch, *targets)
    targets = Array(targets).flatten
    targets.each do |target|
      unless target.included_modules.include? patch
        target.prepend patch
      end
    end
  end

end


plugin_name = 'redmine_stealth'
this_plugin = Redmine::Plugin::find(plugin_name)
plugin_version = '?.?'
if this_plugin
  plugin_version = this_plugin.version
end
