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

class Notification < ActiveRecord::Base
  # 完成度： watering（新たに応援された）complete（応援したミカンが完成した）
  enum kind: %i(watering complete)

  belongs_to :user
  belongs_to :watering, dependent: :destroy
end
