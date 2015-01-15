class Mikanz < ActiveRecord::Base
  validates :name, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_time, presence: true
end
