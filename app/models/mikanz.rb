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

class Mikanz < ActiveRecord::Base
  mount_uploader :mikanz_image, MikanzImageUploader

  acts_as_paranoid
  acts_as_ordered_taggable_on :tags

  # 完成度： justidea（アイデアだけ）start（着手はした）wip（鋭意作成中）nearing（完成間近）complete（完成した！）motivation（やる気待ち）
  enum completion: %i(justidea start wip nearing complete motivation)

  has_many :waterings, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  validates :name, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :completion, presence: true
  validates :url, { :allow_blank => true, :format => URI::regexp(%w(http https)) }

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end
end
