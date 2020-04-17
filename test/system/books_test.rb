# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @user = users(:shimada)
    sign_in @user
  end

  test "books index" do
    visit books_path
    @user.books.each { |book| assert_text book.title }
  end

  test "show book" do
    book = books(:momotaro)
    visit book_path(book)
    assert_text book.title
    assert_text book.memo
    assert_text book.author
  end

  test "create book: succeed" do
    visit new_book_path
    within(id: "book_form") do
      fill_in "book_title", with: "浦島太郎"
      fill_in "book_memo", with: "日本昔話"
      fill_in "book_author", with: "村田"
      click_on I18n.t("operations.post")
    end
    assert_text I18n.t("results.common.create", resource: Book.model_name.human)
  end
  test "create book: fail" do
    visit new_book_path
    within(id: "book_form") do
      fill_in "book_memo", with: "日本昔話"
      fill_in "book_author", with: "村田"
      click_on I18n.t("operations.post")
    end
    assert_text Book.human_attribute_name(:title) + I18n.t("errors.messages.blank")
  end

  test "update book: succeed" do
    visit edit_book_path(books(:momotaro))
    within(id: "book_form") do
      fill_in "book_title", with: "浦島太郎"
      fill_in "book_memo", with: "日本昔話"
      fill_in "book_author", with: "不明"
      click_on I18n.t("operations.post")
    end
    assert_text I18n.t("results.common.update", resource: Book.model_name.human)
  end

  test "update book: fail" do
    visit edit_book_path(books(:momotaro))
    within(id: "book_form") do
      fill_in "book_title", with: ""
      fill_in "book_memo", with: "日本昔話"
      fill_in "book_author", with: "不明"
      click_on I18n.t("operations.post")
    end
    assert_text Book.human_attribute_name(:title) + I18n.t("errors.messages.blank")
  end

  test "destroy book" do
    visit books_path
    accept_confirm do
      click_link I18n.t("operations.destroy"), match: :first
    end
    assert_text I18n.t("results.common.destroy", resource: Book.model_name.human)
  end
end
