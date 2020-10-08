class Micropost < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, -> { distinct }, through: :taggings
  belongs_to :user
  has_many :comments, dependent: :destroy
  self.per_page = 2
  validates :user_id, presence: true
  validates :titel,   presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 140 }
end
