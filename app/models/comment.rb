class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  after_save { |comment| comment.destroy if comment.body.blank? }
  enum localization: { super_admin: 0, admin: 1, user: 2 }
end