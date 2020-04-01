# frozen_string_literal: true

class BooklistsController < ApplicationController
  def index
    followees = current_user.followees
    @books = Book.where(user_id: followees).order(updated_at: :DESC).page params[:page]
    @users = {}
    followees.each do |followee|
      @books.each { |book| @users[book.id] = followee if followee.id == book.user_id }
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page params[:page]
  end
end
