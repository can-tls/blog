class Comment < ApplicationRecord
  belongs_to :micropost
  after_save { |comment| comment.destroy if comment.body.blank? }
end