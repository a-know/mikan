# == Schema Information
#
# Table name: waterings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  mikanz_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :watering do
    # ここらへん、 trait を使ったほうがいいのかな？
    # http://techracho.bpsinc.jp/morimorihoge/2013_08_23/12744
    user
    mikanz
  end
end
