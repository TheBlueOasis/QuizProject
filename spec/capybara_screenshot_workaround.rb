# frozen_string_literal: true

# https://github.com/mattheworiordan/capybara-screenshot/issues/225

require 'action_dispatch/system_testing/test_helpers/setup_and_teardown'
require 'action_dispatch/system_testing/test_helpers/screenshot_helper'

#
# Monkeypatch after_teardown to just call "super". No capybara sessions being reset.
#
::ActionDispatch::SystemTesting::TestHelpers::SetupAndTeardown.module_eval do
  # rubocop:disable Lint/UselessMethodDefinition
  def after_teardown
    super
  end
  # rubocop:enable Lint/UselessMethodDefinition
end

#
# Disabling rails default system test screenshot taking
#
::ActionDispatch::SystemTesting::TestHelpers::ScreenshotHelper.module_eval do
  def take_failed_screenshot
    false
  end
end
