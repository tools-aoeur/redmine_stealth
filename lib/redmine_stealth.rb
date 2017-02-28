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

require_dependency 'redmine_stealth/mail_interceptor'
require_dependency 'redmine_stealth/controller_hooks'
require_dependency 'redmine_stealth/view_hooks'
require_dependency 'redmine_stealth/patches/user_patch'
require_dependency 'redmine_stealth/patches/anonymous_user_patch'

ActionDispatch::Callbacks.to_prepare do
  RedmineStealth.prepend_patch RedmineStealth::Patches::UserPatch, User
  RedmineStealth.prepend_patch RedmineStealth::Patches::AnonymousUserPatch, AnonymousUser
end
