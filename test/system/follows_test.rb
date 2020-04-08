require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers 
  setup do
    @user = users(:shimada)
    sign_in(@user)
  end

  test "follws index" do
    visit follows_path
    
    @user.followees.each { |followee| assert_text followee.name }
  end

  test "create follow" do
    visit users_path
    click_on "フォローする", match: :first
    assert_text"フォローしました"
  end

  test "destroy follow" do
    visit follows_path
    click_on "フォローをやめる", match: :first
    assert_text "フォローをやめました"
  end
end
