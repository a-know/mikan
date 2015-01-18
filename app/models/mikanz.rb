class Mikanz < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  validates :name, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_time, presence: true

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end
end
