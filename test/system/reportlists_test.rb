# frozen_string_literal: true

require "application_system_test_case"

class ReportlistsTest < ApplicationSystemTestCase
  setup do
    @user = users(:shimada)
    sign_in @user
  end

  test "reportlists index" do
    visit reportlists_path
    @user.followees.each do |followee|
      followee.reports.each do |report|
        assert_text report.title
        assert_text report.date
        assert_text report.user.name
      end
    end
  end

  test "show reportlists" do
    report_owner = users(:yamamoto)
    visit reportlist_path(report_owner)
    report_owner.reports.each do |report|
      assert_text report.title
      assert_text report.date
    end
    within("table") do
      assert_no_text I18n.t("operations.destroy")
      assert_no_text I18n.t("operations.edit", resource: "")
    end
  end
end
