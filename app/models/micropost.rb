class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
 # validates :titel,   presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 140 }
end
