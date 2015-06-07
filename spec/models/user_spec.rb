# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string           not null
#  uid        :string           not null
#  nickname   :string           not null
#  image_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'rails_helper'

describe User, :type => :model do
  describe '#find_or_create_from_auth_hash' do
    let(:auth_hash) do
      {
        provider: 'twitter',
        uid: 'a-know',
        info: {
          nickname: 'いのうえ',
          image: 'a-know.jpg'
        }
      }
    end
    subject { User.find_or_create_from_auth_hash(auth_hash) }

    context 'Authorized user is not found in DB' do
      it 'create `a-know` user in DB successfuly' do
        expect do
          @created_user = subject
        end.to change{ User.count }.by(1)
        expect(@created_user.provider).to  eq('twitter')
        expect(@created_user.uid).to       eq('a-know')
        expect(@created_user.nickname).to  eq('いのうえ')
        expect(@created_user.image_url).to eq('a-know.jpg')
        expect(@created_user.notifications.first.kind).to eq('welcome')
      end
    end
    context 'Authorized user is found in DB' do
      before do
        @owner = create(:owner)
        auth_hash[:uid] = @owner.uid
      end
      it 'not create `a-know` user in DB / return User record already saved' do
        expect do
          @created_user = subject
        end.to_not change{ User.count }
        expect(@created_user.provider).to  eq('twitter')
        expect(@created_user.uid).to       eq(@owner.uid)
        expect(@created_user.nickname).to  eq(@owner.nickname)
        expect(@created_user.image_url).to eq('http://example.com/a-know.jpg')
      end
    end
  end
end
