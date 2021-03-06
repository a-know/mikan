# encoding: utf-8
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
  describe '#completion' do
    it { should validate_presence_of(:completion) }
  end
  describe '#url' do
    context 'URL の形式に合致していない場合' do
      let(:invalid_mikanz) { Mikanz.new(attributes_for(:mikanz).merge(url: 'a')) }
      it 'is invalid' do
        expect(invalid_mikanz.valid?).to be_falsey
      end
    end
    context 'http, https 以外のスキーマだった場合' do
      let(:invalid_mikanz) { Mikanz.new(attributes_for(:mikanz).merge(url: 'ftp://www.a-know.jp')) }
      it 'is invalid' do
        expect(invalid_mikanz.valid?).to be_falsey
      end
    end
    context '空だった場合' do
      let(:invalid_mikanz) { Mikanz.new(attributes_for(:mikanz).merge(url: nil)) }
      it 'is invalid' do
        expect(invalid_mikanz.valid?).to be_truthy
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
