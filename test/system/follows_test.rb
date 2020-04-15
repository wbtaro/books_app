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
    click_on "フォローする", match: :first
    assert_text "フォローしました"
  end

  test "create follow: on users page" do
    visit users_path
    click_on "フォローする", match: :first
    assert_text "フォローしました"
  end

  test "destroy follow on follows page" do
    visit follows_path
    click_on "フォローをやめる", match: :first
    assert_text "フォローをやめました"
  end

  test "destroy follow on follwers page" do
    visit follows_path
    click_on "フォローをやめる", match: :first
    assert_text "フォローをやめました"
  end

  test "destroy follow on users page" do
    visit users_path
    click_on "フォローをやめる", match: :first
    assert_text "フォローをやめました"
  end
end
