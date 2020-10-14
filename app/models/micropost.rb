class Micropost < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tags, -> { distinct }, through: :taggings
  belongs_to :user
  self.per_page = 5
  validates :user_id, presence: true
  validates :titel,   presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 140 }
end