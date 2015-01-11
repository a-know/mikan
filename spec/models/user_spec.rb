# encoding: utf-8

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
      end
    end
    context 'Authorized user is found in DB' do
      before { create(:a_know) }
      it 'not create `a-know` user in DB / return User record already saved' do
        expect do
          @created_user = subject
        end.to_not change{ User.count }
        expect(@created_user.provider).to  eq('twitter')
        expect(@created_user.uid).to       eq('a-know')
        expect(@created_user.nickname).to  eq('えーの')
        expect(@created_user.image_url).to eq('http://example.com/a-know.jpg')
      end
    end
  end
end
