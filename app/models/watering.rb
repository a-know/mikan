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

class Watering < ActiveRecord::Base
  belongs_to :user
  belongs_to :mikanz
  has_many :notifications, dependent: :nullify
end
