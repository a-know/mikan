module ApplicationHelper
  def url_for_twitter(user)
    "https://twitter.com/#{user.nickname}"
  end

  def url_for_users_mikanzs(user)
    "/users/#{user.nickname}/mikanzs"
  end

  def owner?(mikanz, user)
    return false unless mikanz.owner
    return false unless user
    owner_id = mikanz.owner.id
    user_id  = user.id
    owner_id == user_id
  end
end
