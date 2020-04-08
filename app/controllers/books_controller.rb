# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @books = Book.where(user_id: current_user.id).page params[:page]
  end

  # GET /books/1
  def show
    @owner = @book.user
    set_posted_comments(@book)
    set_commenters(@book)
    set_new_comment(@book)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to @book, notice: t("results.common.create", resource: t("activerecord.models.book.one"))
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if !current_user_is_owner(@book.user_id)
      redirect_to @book, notice: t("warnings.invalid_operation")
      return
    end

    if @book.update(book_params)
      redirect_to @book, notice: t("results.common.update", resource: t("activerecord.models.book.one"))
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    if !current_user_is_owner(@book.user_id)
      redirect_to @book, notice: t("warnings.invalid_operation")
      return
    end

    @book.destroy
    redirect_to books_url, notice: t("results.common.destroy", resource: t("activerecord.models.book.one"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
