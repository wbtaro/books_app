# frozen_string_literal: true

class DisplayedWithFollowsController < ApplicationController
  # usersのうち、自分がフォローしているユーザーのFollowをセットする
  def set_follows(users)
    @follows = {}
    users.each do |user|
      follow_list.each do |follow|
        @follows[user.id] = follow.id if user.id == follow.followee_id
      end
    end
  end

  def follow_list
    @follow_list ||= current_user.followings
  end
end
