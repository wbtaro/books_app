# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # Get /users
  def index
    @users = User.page params[:page]
    @new_follows = {}
    @users.each { |user| @new_follows[user.id] = Follow.new(followee_id: user.id) }
    set_follows(@users)
  end

  # Get /users/id
  def show
    @new_follow = Follow.new(followee_id: @user.id)
    @follow = current_user.followings.find_by(followee_id: @user.id)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
