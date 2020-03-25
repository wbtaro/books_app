# frozen_string_literal: true

class FollowsController < ApplicationController
  def  index
    @followees = current_user.followees.page params[:page]
    followings = current_user.followings
    @follows = {}
    @followees.each do |followee| 
      followings.each do |follow|
        @follows[followee.id] = Follow.new(id: follow.id) if followee.id == follow.followee_id
      end
    end
  end

  def destroy
    @follow = Follow.find(params[:id])

    # 本人以外のユーザーフォローを削除するのを防ぐ
    if !confirm_user(@follow.follower_id)
      redirect_to follows_path, notice: I18n.t("warnings.invalid_operation")
      return
    end
    
    @follow.destroy
    redirect_to follows_path, notice: I18n.t("results.follows.destroy")
  end

  def create
    @follow = Follow.new(follow_params)
    @follow.follower_id = current_user.id

    if @follow.save
      redirect_to follows_path, notice: I18n.t("results.follows.create")
    else
      redirect_to follows_path, notice: I18n.t("results.follows.already_follow")
    end
  end

  private
  
    def follow_params
      params.require(:follow).permit(:followee_id)
    end
end
