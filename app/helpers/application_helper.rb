module ApplicationHelper
  def url_for_twitter(user)
    "https://twitter.com/#{user.nickname}"
  end

  def owner?(mikanz, user)
    return false unless user
    owner_id = mikanz.owner.id
    user_id  = user.id
    owner_id == user_id
  end
end
