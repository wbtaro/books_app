# frozen_string_literal: true

class FollowsController < DisplayedWithFollowsController
  def  index
    @followees = current_user.followees.page params[:page]
    set_follows(@followees)
  end

  def destroy
    @follow = Follow.find(params[:id])

    # 本人以外のユーザーフォローを削除するのを防ぐ
    if !current_user_is_owner(@follow.follower_id)
      redirect_to follows_path, notice: t("warnings.invalid_operation")
      return
    end

    @follow.destroy
    redirect_to follows_path, notice: t("results.follows.destroy")
  end

  def create
    @follow = Follow.new(follow_params)
    @follow.follower = current_user

    if @follow.save
      redirect_to follows_path, notice: t("results.follows.create")
    else
      redirect_to follows_path, notice: t("results.follows.already_follow")
    end
  end

  private
    def follow_params
      params.require(:follow).permit(:followee_id)
    end
end
