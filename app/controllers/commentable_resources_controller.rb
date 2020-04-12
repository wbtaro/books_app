# frozen_string_literal: true

class CommentableResourcesController < ApplicationController
  def set_posted_comments(commentable_resource)
    @posted_comments = commentable_resource.comments.order(:created_at)
  end

  def set_commenters(commentable_resource)
    @commenters = {}
    @posted_comments.each do |comment|
      commenter_list(commentable_resource).each { |commenter| @commenters[comment.id] = commenter.name if comment.user_id == commenter.id }
    end
  end

  def set_new_comment(commentable_resource)
    @comment = Comment.new(commentable_id: commentable_resource.id, commentable_type: commentable_resource.class, user_id: current_user.id)
  end

  def commenter_list(commentable_resource)
    User.includes(:comments).
          where(comments: { commentable_id: commentable_resource.id, commentable_type: commentable_resource.class.to_s })
  end
end
