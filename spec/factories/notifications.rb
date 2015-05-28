# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  watering_id :integer
#  kind        :integer          not null
#  read        :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :notification do
    user nil
watering nil
kind 1
read false
  end

end
