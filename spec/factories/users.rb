# encoding: utf-8

FactoryGirl.define do
  factory :user, aliases: [:owner] do
    provider 'twitter'
    sequence(:uid) { |i| "a-know-#{i}" }
    nickname 'えーの'
    image_url 'http://example.com/a-know.jpg'
  end
end
