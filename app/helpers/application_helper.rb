# encoding: utf-8

module ApplicationHelper
  def url_for_twitter(user)
    "https://twitter.com/#{user.nickname}"
  end

  def url_for_users_mikanzs(user)
    "/users/#{user.nickname}/mikanzs"
  end

  def url_for_users_watering
    "/user/waterings"
  end

  def path_to_mikanz_image(mikanz)
    mikanz.mikanz_image.blank? ? '/images/noimage.jpg' : mikanz.mikanz_image
  end

  def full_title(page_title)
    base_title = 'みんなの未完成品が集まる場所・Mikanz -ミカンズ-'
    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def owner?(mikanz, user)
    return false unless mikanz.owner
    return false unless user
    owner_id = mikanz.owner.id
    user_id  = user.id
    owner_id == user_id
  end
end
