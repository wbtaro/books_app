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
      click_button I18n.t("devise.registrations.new.sign_up")
    end
    assert_text I18n.t("devise.registrations.signed_up")
  end

  test "sign up: fail because email, name and password are not filled" do
    visit new_user_registration_path
    within(id: "user_form") do
      fill_in "user_postal_code", with: "456-7890"
      fill_in "user_address", with: "仙台"
      fill_in "user_description", with: "仙台といえば伊達"
      click_button I18n.t("devise.registrations.new.sign_up")
    end
    assert_text User.human_attribute_name(:email) + I18n.t("errors.messages.blank")
    assert_text User.human_attribute_name(:name) + I18n.t("errors.messages.blank")
    assert_text User.human_attribute_name(:password) + I18n.t("errors.messages.blank")
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
      click_button I18n.t("devise.registrations.new.sign_up")
    end
    assert_text User.human_attribute_name(:password_confirmation) + I18n.t("errors.messages.confirmation", attribute: User.human_attribute_name(:password))
  end

  test "sign in" do
    visit new_user_session_path
    within(id: "new_user") do
      fill_in "user_email", with: "shimada@example.com"
      fill_in "user_password", with: "aaaaaa"
      click_button I18n.t("devise.sessions.new.sign_in")
    end
    assert_text I18n.t("devise.sessions.signed_in")
  end

  test "sign out" do
    sign_in users(:shimada)
    visit root_path
    click_on I18n.t("devise.sessions.destroy.logout")
    assert_text I18n.t("devise.failure.unauthenticated")
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
      click_on I18n.t("devise.registrations.edit.update")
    end
    assert_text I18n.t("devise.registrations.updated")
  end

  test "update account: fail because email and name are not filled" do
    sign_in users(:shimada)
    visit edit_user_registration_path
    within(id: "user_form") do
      fill_in "user_email", with: ""
      fill_in "user_name", with: ""
      click_on I18n.t("devise.registrations.edit.update")
    end
    assert_text User.human_attribute_name(:email) + I18n.t("errors.messages.blank")
    assert_text User.human_attribute_name(:name) + I18n.t("errors.messages.blank")
  end

  test "update account: fail because password is not same as password_confirmation" do
    sign_in users(:shimada)
    visit edit_user_registration_path
    within(id: "user_form") do
      fill_in "user_password", with: "aaaaaa"
      fill_in "user_password_confirmation", with: "bbbbbb"
      click_on I18n.t("devise.registrations.edit.update")
    end
    assert_text User.human_attribute_name(:password_confirmation) + I18n.t("errors.messages.confirmation", attribute: User.human_attribute_name(:password))
  end

  test "cancel account" do
    sign_in users(:shimada)
    visit edit_user_registration_path
    accept_confirm do
      click_on I18n.t("devise.registrations.edit.cancel_my_account")
    end
    assert_text I18n.t("devise.failure.unauthenticated")
  end
end
