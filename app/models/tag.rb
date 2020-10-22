class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :microposts, through: :taggings
  after_save { |tag| tag.destroy if tag.name.blank? }
end
