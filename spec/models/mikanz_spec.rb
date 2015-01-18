require 'rails_helper'

RSpec.describe Mikanz, :type => :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(50) }
  end
  describe '#content' do
    it { should validate_presence_of(:content) }
    it { should ensure_length_of(:content).is_at_most(2000) }
  end
  describe '#start_time' do
    it { should validate_presence_of(:start_time) }
  end
end
