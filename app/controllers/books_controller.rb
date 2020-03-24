# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @books = Book.where(user_id: current_user.id).page params[:page]
  end

  # GET /books/1
  def show
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
    @book.user_id = current_user.id

    if @book.save
      redirect_to @book, notice: I18n.t("results.create")
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if !confirm_user(@book.user_id)
      redirect_to @book, notice: "無効な操作です"
      return
    end

    if @book.update(book_params)
      redirect_to @book, notice: I18n.t("results.update")
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    if !confirm_user(@book.user_id)
      redirect_to @book, notice: "無効な操作です"
      return
    end

    @book.destroy
    redirect_to books_url, notice: I18n.t("results.destroy")
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
