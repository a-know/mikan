# encoding: utf-8

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string           not null
#  uid        :string           not null
#  nickname   :string           not null
#  image_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :created_mikanzs, class_name: 'Mikanz', foreign_key: :owner_id, dependent: :destroy
  has_many :waterings, dependent: :nullify
  has_many :notifications, dependent: :destroy

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
      Notification.create!(user: user, watering: nil, kind: 2, read: false)
      Notifier.new.post("ユーザー新規登録：#{nickname}")
    end
  end
end
