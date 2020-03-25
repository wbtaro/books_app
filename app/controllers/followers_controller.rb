class FollowersController < ApplicationController
  def index
    @followers = current_user.followers.page params[:page]
    @follows = {}
    @followers.each { |user| @follows[user.id] = Follow.new(followee_id: user.id) }
  end
end
