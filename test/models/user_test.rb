# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "create_unique_string" do
    assert_not_equal(User.create_unique_string, User.create_unique_string)
  end

  test "update_with_password: succeedd" do
    @user = users(:shimada)
    params = {
      email: "shimada@example.com",
      password: "bbbbbb",
      password_confirmation: "bbbbbb",
      name: "島田",
      postal_code: "999-999",
      address: "岡山",
      description: "岡山に引っ越しました"
    }
    assert @user.update_with_password(params)
  end

  test "update_with_password: fail because passowrd is not same as password_confirmation" do
    @user = users(:shimada)
    params = {
      email: "shimada@example.com",
      password: "bbbbbb",
      password_confirmation: "cccccc",
      name: "島田",
      postal_code: "999-999",
      address: "岡山",
      description: "岡山に引っ越しました"
    }
    assert_not @user.update_with_password(params)
  end

  test "find_for_github_oauth: regster already existing user on DB" do
    info = OmniAuth::AuthHash.new(
      name: "山本",
      email: "yamamoto@example.com"
    )
    auth = OmniAuth::AuthHash.new(
      provider: "GitHub",
      uid: "12345",
      info: info
    )
    assert User.find_by(provider: auth.provider, uid: auth.uid)
    assert User.find_for_github_oauth(auth)
  end

  test "find_for_github_oauth: register not existing user on DB" do
    info = OmniAuth::AuthHash.new(
      name: "徳川",
      email: "tokugawa@example.com"
    )
    auth = OmniAuth::AuthHash.new(
      provider: "GitHub",
      uid: "999999",
      info: info
    )
    assert User.find_for_github_oauth(auth)
    assert User.find_by(provider: auth.provider, uid: auth.uid)
  end
end
