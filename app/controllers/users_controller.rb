# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # Get /users
  def index
    @users = User.page params[:page]
  end

  # Get /users/id
  def show
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
