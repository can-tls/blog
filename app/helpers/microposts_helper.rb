module MicropostsHelper
  def micropost_from_current_user?(post)
    return false if !current_user.present?
    post.user_id == current_user.id
  end
end