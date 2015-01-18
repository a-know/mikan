FactoryGirl.define do
  factory :mikanz do
    sequence(:owner_id) { |i| i }
    sequence(:name) { |i| "MyString-#{i}" }
    start_time "2015-01-15 14:30:44"
    content "MyText"
  end
end
