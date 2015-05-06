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

class Mikanz < ActiveRecord::Base
  mount_uploader :mikanz_image, MikanzImageUploader

  acts_as_paranoid
  acts_as_ordered_taggable_on :tags

  has_many :waterings, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  validates :name, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_time, presence: true
  validates :completion, presence: true, numericality: {
            only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 99
          }

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end
end
