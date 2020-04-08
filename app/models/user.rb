# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(github)
  paginates_per 5
  has_one_attached :avatar
  has_many :followings, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  has_many :followees, through: :followings, class_name: "User", dependent: :destroy
  has_many :followed, foreign_key: :followee_id, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :followed, class_name: "User", dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  def update_with_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update(params, *options)

    clean_up_passwords
    result
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(provider: auth.provider,
                      uid:      auth.uid,
                      name:     auth.info.name,
                      email:    auth.info.email,
                      password: Devise.friendly_token[0, 20]
      )
    end
    user.save
    user
  end
end
