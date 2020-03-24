# frozen_string_literal: true

class FollowsController < ApplicationController
  def  index
    @followees = current_user.followees.page params[:page]
    follows = current_user.followings
    @follow_list = {}
    @followees.each do |followee| 
      follows.each do |follow|
        @follow_list[followee.id] = follow.id if followee.id == follow.followee_id
      end
    end
    p @follow_list
  end

  def destroy
    @follow = Follow.find(params[:id])

    # 本人以外のユーザーフォローを削除するのを防ぐ
    if !confirm_user(@follow.follower_id)
      redirect_to follows_path, notice: "無効な操作です"
      return
    end
    
    @follow.destroy
    redirect_to follows_path, notice: "フォローをやめました"
  end

  def create
    @follow = Follow.new(follow_params)
    @follow.follower_id = current_user.id

    if @follow.save
      redirect_to follows_path, notice: "フォローしました"
    else
      redirect_to follows_path, notice: "すでにフォローしています"
    end
  end

  private
  
    def follow_params
      params.require(:follow).permit(:followee_id)
    end
end
