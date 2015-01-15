class Mikanz < ActiveRecord::Base
  validates :name, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_time, presence: true
  validate  :start_time_should_be_before_end_time
end
