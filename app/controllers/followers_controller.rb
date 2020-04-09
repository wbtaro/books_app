# frozen_string_literal: true

class FollowersController < DisplayedWithFollowsController
  def index
    @followers = current_user.followers.page params[:page]
    @new_follows = {}
    @followers.each { |user| @new_follows[user.id] = Follow.new(followee_id: user.id) }
    set_follows(@followers)
  end
end
