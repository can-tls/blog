class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :titel,   presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 140 }
end
