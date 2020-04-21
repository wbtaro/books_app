# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user = users(:shimada)
    sign_in @user
  end

  test "reports index" do
    visit reports_path
    @user.reports.each do |report|
      assert_text report.title
      assert_text report.date
    end
  end

  test "create report: succeed" do
    visit new_report_path
    within(id: "report_form") do
      fill_in "report_title", with: "Railsの学習3"
      fill_in "report_date", with: "2020-04-01"
      fill_in "report_text", with: "Railsのルーティングについて学習しました"
      click_on I18n.t("operations.post")
    end
    assert_text I18n.t("results.common.create", resource: Report.model_name.human)
  end

  test "create report: fail because title, date and text are not filled" do
    visit new_report_path
    within(id: "report_form") do
      fill_in "report_title", with: ""
      fill_in "report_date", with: ""
      fill_in "report_text", with: ""
      click_on I18n.t("operations.post")
    end
    assert_text Report.human_attribute_name(:title) + I18n.t("errors.messages.blank")
    assert_text Report.human_attribute_name(:date) + I18n.t("errors.messages.blank")
    assert_text Report.human_attribute_name(:text) + I18n.t("errors.messages.blank")
  end

  test "show report" do
    report = reports(:shimada_1)
    visit report_path(report)
    assert_text report.title
    assert_text report.date
    assert_text report.text
  end

  test "update report: succeed" do
    visit edit_report_path(reports(:shimada_1))
    within(id: "report_form") do
      fill_in "report_title", with: "JSの学習1"
      fill_in "report_date", with: "2019-12-31"
      fill_in "report_text", with: "JSの文法を学習しました"
      click_on I18n.t("operations.post")
    end
    assert_text I18n.t("results.common.update", resource: Report.model_name.human)
  end

  test "update report: fail because title, date and text are not filled" do
    visit edit_report_path(reports(:shimada_1))
    within(id: "report_form") do
      fill_in "report_title", with: ""
      fill_in "report_date", with: ""
      fill_in "report_text", with: ""
      click_on I18n.t("operations.post")
    end
    assert_text Report.human_attribute_name(:title) + I18n.t("errors.messages.blank")
    assert_text Report.human_attribute_name(:date) + I18n.t("errors.messages.blank")
    assert_text Report.human_attribute_name(:text) + I18n.t("errors.messages.blank")
  end

  test "destroy report" do
    visit reports_path
    accept_confirm do
      click_link I18n.t("operations.destroy"), match: :first
    end
    assert_text I18n.t("results.common.destroy", resource: Report.model_name.human)
  end
end
