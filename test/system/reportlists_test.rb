require "application_system_test_case"

class ReportlistsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers 
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
      assert_no_text "削除"
      assert_no_text "編集"
    end
  end
end
