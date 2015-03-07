# encoding: utf-8

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#destroy' do
    let(:user) { create(:user) }
    subject { delete :destroy }
    before { session[:user_id] = user.id }

    it 'ユーザーの削除が行われること' do
      subject
      expect do
        User.find(user.id)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'セッションがクリアされていること' do
      subject
      expect(session[:user_id]).to be_nil
    end

    it 'root_path にリダイレクトされること' do
      subject
      expect(response).to redirect_to(root_path)
    end
  end
end
