# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  validates :title, presence: true
  validates :date, presence: true
  validates :text, presence: true
  paginates_per 5
end
