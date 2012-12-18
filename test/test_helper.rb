helper_path = '/../../test/test_helper'

helper = File.expand_path(File.dirname(__FILE__) + helper_path)

# Rails 2
if !File.exists?(helper)
  helper = File.expand_path(File.dirname(__FILE__) + "/.." + helper_path)
end

require helper
