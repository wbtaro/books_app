# frozen_string_literal: true

class BooklistsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books.page params[:page]
  end
end
