# encoding: utf-8

FactoryGirl.define do
  factory :user, aliases: [:a_know] do
    provider 'twitter'
    uid 'a-know'
    nickname 'えーの'
    image_url 'http://example.com/a-know.jpg'
  end
end
