require "test_helper"
 
class TestUser < ActiveSupport::TestCase
  test "create_unique_stringが毎回異なる値を返す" do
    assert_not_equal(User.create_unique_string, User.create_unique_string)
  end

  test "update_with_passwordでcurrent_passwordなしで情報更新する（パスワード含めない）" do
    @john = users(:john)
    params = {
      email: "john@example.com",
      name: "John",
      postal_code: "999-999",
      address: "Tokyo",
      description: "OK!!"
    }
    assert @john.update_with_password(params)
  end

  test "update_with_passwordでcurrent_passwordなしで情報更新する（パスワード含める）" do
    @john = users(:john)
    params = {
      email: "john@example.com",
      password: "bbbbbb",
      password_confirmation: "bbbbbb",
      name: "John",
      postal_code: "999-999",
      address: "Tokyo",
      description: "OK!!"
    }
    assert @john.update_with_password(params)
  end

  test "find_for_github_oauthですでにDBに登録済み" do
    info = OmniAuth::AuthHash.new(
      name: "Bob",
      email: "Bob@example.com"
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
      name: "Taro",
      email: "taro@example.com"
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