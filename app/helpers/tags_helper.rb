module TagsHelper
  def tag_from_current_user?(tag)
    return false if !current_user.present?
    tag.user_id == current_user.id
  end
end