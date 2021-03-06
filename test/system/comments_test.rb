# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    sign_in users(:shimada)
  end

  test "list comments on books" do
    commented_book = books(:akazukin)
    visit book_path(commented_book)
    commented_book.comments.each do |comment|
      assert_text comment.user.name
      assert_text comment.created_at
      assert_text comment.text
    end
  end

  test "list comment on reports" do
    commented_report = reports(:yamamoto_1)
    visit report_path(commented_report)
    commented_report.comments.each do |comment|
      assert_text comment.user.name
      assert_text comment.created_at
      assert_text comment.text
    end
  end

  test "create comment to books" do
    visit book_path(books(:akazukin))
    within(id: "comment_form") do
      fill_in "comment_text", with: "頑張ってください"
      click_on I18n.t("operations.post")
    end
    assert_text I18n.t("results.common.create", resource: Comment.model_name.human)
  end

  test "create comment to reports" do
    visit report_path(reports(:yamamoto_1))
    within(id: "comment_form") do
      fill_in "comment_text", with: "頑張ってください"
      click_on I18n.t("operations.post")
    end
    assert_text I18n.t("results.common.create", resource: Comment.model_name.human)
  end

  # 編集画面はコメントが付いたオブジェクトにかかわらず共通なので
  # テストケースも一つ
  test "update comment" do
    visit edit_comment_path(comments(:shimada_to_yamamoto_book_1))
    within(id: "comment_form") do
      fill_in "comment_text", with: "私も読みましたが、面白かったです"
      click_on I18n.t("operations.post")
    end
    assert_text I18n.t("results.common.update", resource: Comment.model_name.human)
  end

  test "destroy commnet on books" do
    visit book_path(books(:akazukin))
    accept_confirm do
      click_link I18n.t("operations.destroy"), match: :first
    end
    assert_text I18n.t("results.common.destroy", resource: Comment.model_name.human)
  end

  test "destroy comment on reports" do
    visit report_path(reports(:yamamoto_1))
    accept_confirm do
      click_link I18n.t("operations.destroy"), match: :first
    end
    assert_text I18n.t("results.common.destroy", resource: Comment.model_name.human)
  end
end
