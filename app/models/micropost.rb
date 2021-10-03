class Micropost < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_micropost, against: %i[titel content]

  has_many :taggings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tags, -> { distinct }, through: :taggings
  belongs_to :user

  validates :user_id, presence: true
  validates :titel,   presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 140 }

  def current_user_id
    if current_user.present?
      @current_id = current_user.id
    end
  end

  def current_user_name
    if current_user.present?
      @current_name = current_user.name
    end
  end

  def online_user_comment
    if current_user.present?
      @comments = Comment.new(name: current_user.name, user_id: current_user.id)
    end
  end
end