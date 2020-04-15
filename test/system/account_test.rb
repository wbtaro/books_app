# frozen_string_literal: true

require "application_system_test_case"

class AccountTest < ApplicationSystemTestCase
  test "sign up: succeed" do
    visit new_user_registration_path
    within(id: "user_form") do
      fill_in "user_email", with: "date@example.com"
      fill_in "user_name", with: "伊達"
      fill_in "user_postal_code", with: "456-7890"
      fill_in "user_address", with: "仙台"
      fill_in "user_description", with: "仙台といえば伊達"
      fill_in "user_password", with: "aaaaaa"
      fill_in "user_password_confirmation", with: "aaaaaa"
      click_button "アカウント登録"
    end
    assert_text "アカウント登録が完了しました"
  end

  test "sign up: fail because email, name and password are not filled" do
    visit new_user_registration_path
    within(id: "user_form") do
      fill_in "user_postal_code", with: "456-7890"
      fill_in "user_address", with: "仙台"
      fill_in "user_description", with: "仙台といえば伊達"
      click_button "アカウント登録"
    end
    assert_text "Eメールを入力してください"
    assert_text "名前を入力してください"
    assert_text "パスワードを入力してください"
  end

  test "sign up: fail because password is not same as password_confirmation" do
    visit new_user_registration_path
    within(id: "user_form") do
      fill_in "user_email", with: "date@example.com"
      fill_in "user_name", with: "伊達"
      fill_in "user_postal_code", with: "456-7890"
      fill_in "user_address", with: "仙台"
      fill_in "user_description", with: "仙台といえば伊達"
      fill_in "user_password", with: "aaaaaa"
      fill_in "user_password_confirmation", with: "bbbbbb"
      click_button "アカウント登録"
    end
    assert_text "パスワード（確認用）とパスワードの入力が一致しません"
  end

  test "sign in" do
    visit new_user_session_path
    within(id: "new_user") do
      fill_in "user_email", with: "shimada@example.com"
      fill_in "user_password", with: "aaaaaa"
      click_button "ログイン"
    end
    assert_text "ログインしました"
  end

  test "sign out" do
    sign_in users(:shimada)
    visit root_path
    click_on "ログアウト"
    assert_text "アカウント登録もしくはログインしてください。"
  end

  test "update account: succeed" do
    sign_in users(:shimada)
    visit edit_user_registration_path
    within(id: "user_form") do
      fill_in "user_email", with: "date@example.com"
      fill_in "user_name", with: "伊達"
      fill_in "user_postal_code", with: "000-0000"
      fill_in "user_address", with: "盛岡"
      fill_in "user_description", with: "わんこそば大好き"
      fill_in "user_password", with: "aaaaaa"
      fill_in "user_password_confirmation", with: "aaaaaa"
      click_on "更新"
    end
    assert_text "アカウント情報を変更しました"
  end

  test "update account: fail because email and name are not filled" do
    sign_in users(:shimada)
    visit edit_user_registration_path
    within(id: "user_form") do
      fill_in "user_email", with: ""
      fill_in "user_name", with: ""
      click_on "更新"
    end
    assert_text "Eメールを入力してください"
    assert_text "名前を入力してください"
  end

  test "update account: fail because password is not same as password_confirmation" do
    sign_in users(:shimada)
    visit edit_user_registration_path
    within(id: "user_form") do
      fill_in "user_password", with: "aaaaaa"
      fill_in "user_password_confirmation", with: "bbbbbb"
      click_on "更新"
    end
    assert_text "パスワード（確認用）とパスワードの入力が一致しません"
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
