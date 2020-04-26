class Comment < ApplicationRecord
  belongs_to :micropost
end
comment = Comment.first
comments = Comment.all