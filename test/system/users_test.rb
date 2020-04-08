require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers 
  setup do
    @user = users(:shimada)
    sign_in @user
  end

  test "users index" do
    visit users_path

    users.each do |other_user|
      next if other_user == @user
      assert_text other_user.name
      assert_text other_user.email
    end
  end

  test "show user without avatar" do
    other_user = users(:yamamoto)
    visit user_path(other_user)

    assert_text other_user.name
    assert_text other_user.email
    assert_text other_user.postal_code
    assert_text other_user.address
    assert_text other_user.description
  end

  # test "show user with avatar" do
  #   other_user = users(:inoue)
  #   visit user_path(other_user)

  #   assert_text other_user.name
  #   assert_text other_user.avatar
  #   assert_text other_user.email
  #   assert_text other_user.postal_code
  #   assert_text other_user.address
  #   assert_text other_user.description
  # end
end
