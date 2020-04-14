# frozen_string_literal: true

require "application_system_test_case"

class BooklistsTest < ApplicationSystemTestCase
  setup do
    @user = users(:shimada)
    sign_in @user
  end

  test "booklist index" do
    visit booklists_path
    @user.followees.each do |followee|
      followee.books.each do |book|
        assert_text book.title
        assert_text book.user.name
      end
    end
    within("table") do
      assert_no_text "削除"
      assert_no_text "編集"
    end
  end

  test "show booklist" do
    booklist_owner = users(:yamamoto)
    visit booklist_path(booklist_owner)
    booklist_owner.books.each { |book| assert_text book.title }
    within("table") do
      assert_no_text "削除"
      assert_no_text "編集"
    end
  end
end
