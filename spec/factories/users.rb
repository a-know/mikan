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


FactoryGirl.define do
  factory :user, aliases: [:owner] do
    provider 'twitter'
    sequence(:uid) { |i| "a-know-#{i}" }
    nickname 'えーの'
    image_url 'http://example.com/a-know.jpg'
  end
end
