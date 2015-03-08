# encoding: utf-8
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


require 'rails_helper'

RSpec.describe Mikanz, :type => :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end
  describe '#content' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(2000) }
  end
  describe '#start_time' do
    it { should validate_presence_of(:start_time) }
  end
  describe '#completion' do
    it { should validate_presence_of(:completion) }
    it { should validate_numericality_of(:completion) }
    context 'value is less than 0' do
      it 'not valid' do
        mikanz = Mikanz.new(completion: -1)
        mikanz.valid?
        expect(mikanz.errors[:completion]).to be_present
      end
    end
    context 'value is more than 99' do
      it 'not valid' do
        mikanz = Mikanz.new(completion: 100)
        mikanz.valid?
        expect(mikanz.errors[:completion]).to be_present
      end
    end
  end

  describe '#created_by?' do
    before { @mikanz = create(:mikanz) }
    subject { @mikanz.created_by?(user) }

    context '引数で渡されたユーザーが、そのミカンのオーナーである場合' do
      let(:user) { @mikanz.owner }
      it 'true が得られること' do
        expect(subject).to be_truthy
      end
    end

    context '引数で渡されたユーザーが、そのミカンのオーナーでない場合' do
      let(:user) { create(:user) }
      it 'true が得られること' do
        expect(subject).to be_falsey
      end
    end
  end
end
