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
