require "application_system_test_case"

class AccountTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers 

  test "sign up" do
    visit new_user_registration_path

    fill_in "user_email", with: "date@example.com"
    fill_in "user_name", with: "伊達"
    fill_in "user_postal_code", with: "456-7890"
    fill_in "user_address", with: "仙台"
    fill_in "user_description", with: "仙台といえば伊達"
    fill_in "user_password", with: "aaaaaa"
    fill_in "user_password_confirmation", with: "aaaaaa"
    click_button "アカウント登録"
    assert_text "アカウント登録が完了しました"
  end

  test "sign in" do
    visit new_user_session_path

    fill_in "user_email", with: "shimada@example.com"
    fill_in "user_password", with: "aaaaaa"
    click_button "ログイン"
    assert_text "ログインしました"
  end

  test "sign out" do
    sign_in users(:shimada)
    visit root_path
    click_on "ログアウト"
    assert_text "アカウント登録もしくはログインしてください。"
  end

  test "edit account" do
    sign_in users(:shimada)
    visit edit_user_registration_path
    fill_in "user_name", with: "伊達"
    fill_in "user_postal_code", with: "456-7890"
    fill_in "user_address", with: "仙台"
    fill_in "user_description", with: "仙台といえば伊達"
    fill_in "user_password", with: "aaaaaa"
    fill_in "user_password_confirmation", with: "aaaaaa"
    click_on "更新"
    assert_text "アカウント情報を変更しました"
  end

  test "cancel account" do
    sign_in users(:shimada)
    visit edit_user_registration_path
    accept_confirm do
      click_on "アカウント削除"
    end
    assert_text "アカウント登録もしくはログインしてください。"
  end
end
 