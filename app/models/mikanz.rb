class Mikanz < ActiveRecord::Base
  acts_as_paranoid
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
