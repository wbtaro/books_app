# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
    def set_locale
      if params[:locale]
        I18n.locale = params[:locale]
      else
        extracted_locale = extract_locale_from_accept_language
        I18n.locale = (I18n.available_locales.include? extracted_locale.to_sym) ?
                    extracted_locale : I18n.default_locale
      end
    end

    def default_url_options(options = {})
      { locale: I18n.locale }.merge options
    end

    def extract_locale_from_accept_language
      request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first
    end

    # ログインユーザー以外のユーザーによる削除を防ぐ
    def current_user_is_owner(owner_id)
      owner_id == current_user.id
    end

    # usersのうち、自分がフォローしているユーザーのFollowをセットする
    def set_follows(users)
      followings = current_user.followings
      @follows = {}
      users.each do |user|
        followings.each do |follow|
          @follows[user.id] = follow.id if user.id == follow.followee_id
        end
      end
    end

    def set_comments_and_new_comment(commentable_resource)
      @posted_comments = commentable_resource.comments
      temp_commenters = User.includes(:comments).where(comments: { commentable_id: commentable_resource.id })
      @commenters = {}
      @posted_comments.each do |comment|
        temp_commenters.each do |commenter|
          if comment.user_id == commenter.id
            @commenters[comment.id] = commenter.name
          end
        end
      end
      @posted_comments = @posted_comments.sort { |a, b| a.updated_at <=> b.updated_at }
      @comment = Comment.new(commentable_id: commentable_resource.id, commentable_type: commentable_resource.class, user_id: current_user.id)
    end

  protected
    def update_resource(resource, params)
      if params[:password].present? && params[:password_confirmation].present?
        resource.update_attributes(params)
      else
        resource.update_without_password(params)
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code, :address, :description, :avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal_code, :address, :description, :avatar])
    end
end
