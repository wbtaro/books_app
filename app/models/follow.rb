# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"
  paginates_per 5
  validates :follower_id, uniqueness: { scope: :followee_id }
end
