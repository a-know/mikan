# encoding: utf-8
# == Schema Information
#
# Table name: mikanzs
#
#  id           :integer          not null, primary key
#  owner_id     :integer
#  name         :string           not null
#  content      :text             not null
#  created_at   :datetime
#  updated_at   :datetime
#  deleted_at   :datetime
#  completion   :integer          default(0)
#  mikanz_image :string
#  start_year   :integer
#  start_month  :integer
#  url          :string
#

FactoryGirl.define do
  factory :mikanz do
    owner
    sequence(:name) { |i| "MyString-#{i}" }
    content "MyText"
    completion 'wip'
    sequence(:mikanz_image)       { |i| "MyString-#{i}.jpg" }
    sequence(:mikanz_image_cache) { |i| "MyString-#{i}.jpg.cache" }
    remove_mikanz_image false
    tag_list '手芸,手作り'
    start_year 2015
    start_month 5
    url 'http://home.a-know.me/'
  end
end
