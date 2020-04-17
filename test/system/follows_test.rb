# frozen_string_literal: true

require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  setup do
    @user = users(:shimada)
    sign_in(@user)
  end

  test "follws index" do
    visit follows_path

    @user.followees.each { |followee| assert_text followee.name }
  end

  test "create follow on followers page" do
    visit followers_path
    click_on I18n.t("operations.follow"), match: :first
    assert_text I18n.t("results.follows.create")
  end

  test "create follow: on users page" do
    visit users_path
    click_on I18n.t("operations.follow"), match: :first
    assert_text I18n.t("results.follows.create")
  end

  test "destroy follow on follows page" do
    visit follows_path
    click_on I18n.t("operations.cancel_follow"), match: :first
    assert_text I18n.t("results.follows.destroy")
  end

  test "destroy follow on follwers page" do
    visit follows_path
    click_on I18n.t("operations.cancel_follow"), match: :first
    assert_text I18n.t("results.follows.destroy")
  end

  test "destroy follow on users page" do
    visit users_path
    click_on I18n.t("operations.cancel_follow"), match: :first
    assert_text I18n.t("results.follows.destroy")
  end
end
