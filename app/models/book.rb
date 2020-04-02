# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  mount_uploader :picture, PictureUploader
  validates :title, presence: true
  paginates_per 5
end
