
class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # Get /users
  def index
    @users = User.page params[:page]
    @follows = {}
    @users.each { |user| @follows[user.id] = Follow.new(followee_id: user.id) }
  end

  # Get /users/id
  def show
    @follow = Follow.new(followee_id: @user.id)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
