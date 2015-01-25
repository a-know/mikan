FactoryGirl.define do
  factory :mikanz do
    owner
    sequence(:name) { |i| "MyString-#{i}" }
    start_time "2015-01-15 14:30:44"
    content "MyText"
    completion 55
  end
end
