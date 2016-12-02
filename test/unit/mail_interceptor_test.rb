require File.dirname(__FILE__) + '/../test_helper'

class UserPatchTest < ActiveSupport::TestCase
  fixtures :projects, :users, :email_addresses, :user_preferences, :members, :member_roles, :roles,
    :groups_users,
    :trackers, :projects_trackers,
    :enabled_modules,
    :versions,
    :issue_statuses, :issue_categories, :issue_relations, :workflows,
    :enumerations,
    :issues, :journals, :journal_details,
    :custom_fields, :custom_fields_projects, :custom_fields_trackers, :custom_values,
    :time_entries

  def setup
    @user = User.find(1)
    @user.update_attribute :stealth_allowed, true
    User.current                       = @user
    ActionMailer::Base.delivery_method = :test
  end

  def test_create_should_not_send_email_notification
    @user.activate_stealth_mode
    ActionMailer::Base.deliveries.clear
    issue = build_issue
    with_settings notified_events: %w(issue_added) do
      assert issue.save
      assert_equal 0, ActionMailer::Base.deliveries.size
    end
  end

  def test_create_should_send_email_notification
    @user.deactivate_stealth_mode
    ActionMailer::Base.deliveries.clear
    issue = build_issue
    with_settings notified_events: %w(issue_added) do
      assert issue.save
      assert_equal 1, ActionMailer::Base.deliveries.size
    end
  end

  private

  def build_issue
    Issue.new(
      project_id: 1,
      tracker_id: 1,
      author_id:  3, status_id: 1,
      priority:   IssuePriority.all.first,
      subject:    'test_create', estimated_hours: '1:30'
    )
  end

end