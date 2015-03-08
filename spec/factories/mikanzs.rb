# == Schema Information
#
# Table name: mikanzs
#
#  id           :integer          not null, primary key
#  owner_id     :integer
#  name         :string           not null
#  start_time   :datetime         not null
#  content      :text             not null
#  created_at   :datetime
#  updated_at   :datetime
#  deleted_at   :datetime
#  completion   :integer          default("0")
#  mikanz_image :string
#

FactoryGirl.define do
  factory :mikanz do
    owner
    sequence(:name) { |i| "MyString-#{i}" }
    start_time "2015-01-15 14:30:44"
    content "MyText"
    completion 55
    sequence(:mikanz_image)       { |i| "MyString-#{i}.jpg" }
    sequence(:mikanz_image_cache) { |i| "MyString-#{i}.jpg.cache" }
    remove_mikanz_image false
  end
end
