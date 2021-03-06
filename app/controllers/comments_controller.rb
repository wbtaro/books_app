# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to commented_resource, notice: t("results.common.create", resource: t("activerecord.models.comment.one"))
    else
      redirect_to commented_resource
    end
  end

  # PATCH/PUT /comments/1
  def update
    if !current_user_is_owner(@comment.user_id)
      redirect_to commented_resource, notice: t("warnings.invalid_operation")
      return
    end

    if @comment.update(comment_params)
      redirect_to commented_resource, notice: t("results.common.update", resource: t("activerecord.models.comment.one"))
    else
      redirect_to commented_resource
    end
  end

  # DELETE /comments/1
  def destroy
    if !current_user_is_owner(@comment.user_id)
      redirect_to commented_resource, notice: t("warnings.invalid_operation")
      return
    end

    @comment.destroy
    redirect_to commented_resource, notice: t("results.common.destroy", resource: t("activerecord.models.comment.one"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:text, :commentable_id, :commentable_type)
    end

    def commented_resource
      commentable_class = @comment.commentable_type.constantize
      commentable_class.find(@comment.commentable_id)
    end
end
