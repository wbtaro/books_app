require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers 
  setup do
    @user = users(:shimada)
    sign_in @user
  end

  test "books index" do
    visit books_path

    @user.books.each { |book| assert_text book.title}
  end

  test "create book" do
    visit new_book_path

    fill_in "book_title", with: "浦島太郎"
    fill_in "book_memo", with: "日本昔話"
    fill_in "book_author", with: "村田"
    click_on "投稿する"

    assert_text "本情報を作成しました"
  end

  test "show book" do
    book = books(:momotaro)
    visit book_path(book)
    assert_text book.title
    assert_text book.memo
    assert_text book.author
  end

  test "update book" do
    visit edit_book_path(books(:momotaro))

    fill_in "book_title", with: "浦島太郎"
    fill_in "book_memo", with: "日本昔話"
    fill_in "book_author", with: "不明"
    click_on "投稿する"
    assert_text "本情報を更新しました"
  end

  test "destroy book" do
    visit books_path

    accept_confirm do
      click_link "削除", match: :first
    end
    assert_text "本情報を削除しました"
  end
end
