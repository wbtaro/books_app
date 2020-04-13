# frozen_string_literal: true

require "application_system_test_case"

class FollowersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:shimada)
    sign_in @user
  end

  test "followers index" do
    visit followers_path
    @user.followers.each do |follower|
      assert_text follower.name
    end
  end
end
