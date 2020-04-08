require "test_helper"
 
class TestUser < ActiveSupport::TestCase
  test "create_unique_string" do
    assert_not_equal(User.create_unique_string, User.create_unique_string)
  end

  test "update_with_password without password" do
    @john = users(:shimada)
    params = {
      email: "shimada@example.com",
      name: "島田",
      postal_code: "999-999",
      address: "岡山",
      description: "岡山に引っ越しました"
    }
    assert @john.update_with_password(params)
  end

  test "update_with_password with password" do
    @john = users(:shimada)
    params = {
      email: "shimada@example.com",
      password: "bbbbbb",
      password_confirmation: "bbbbbb",
      name: "島田",
      postal_code: "999-999",
      address: "岡山",
      description: "岡山に引っ越しました"
    }
    assert @john.update_with_password(params)
  end

  test "find_for_github_oauthですでにDBに登録済み" do
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

  test "find_for_github_oauthでまだDBに登録済みでない" do
    info = OmniAuth::AuthHash.new(
      name: "徳川",
      email: "tokugawa@example.com"
    )
    auth = OmniAuth::AuthHash.new(
      provider: "GitHub",
      uid: "999999",
      info: info
    )
    assert_nil User.find_by(provider: auth.provider, uid: auth.uid)
    assert User.find_for_github_oauth(auth)
    assert_not_nil User.find_by(provider: auth.provider, uid: auth.uid)
  end
end
