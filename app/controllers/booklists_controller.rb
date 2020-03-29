# frozen_string_literal: true

class BooklistsController < ApplicationController
  def index
    followees = current_user.followees
    @books = []
    @users = {}
    followees.each do |followee|
      followee_books = Book.where(user_id: followee.id)
      followee_books.each { |book| @users[book.id] = followee }
      @books += followee_books
    end
    @books.sort_by! { |book| book.updated_at }
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page params[:page]
  end
end
