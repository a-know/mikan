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

  describe '#notifications' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:mikanz1) { create(:mikanz) }
    let(:watering1) { create(:watering, mikanz: mikanz1) }
    let(:mikanz2) { create(:mikanz) }
    let(:watering2) { create(:watering, mikanz: mikanz2) }
    let(:user1_notification1) { create(:notification, user: user1, read: true) }
    let(:user1_notification2) { create(:notification, user: user1, read: false, watering: watering1) }
    let(:user1_notification3) { create(:notification, user: user1, read: false, watering: watering2) }
    let(:user1_notification4) { create(:notification, user: user1, read: true) }
    let(:user2_notification1) { create(:notification, user: user2, read: true) }
    let(:user2_notification2) { create(:notification, user: user2, read: false) }

    before do
      session[:user_id] = user1.id
      user1_notification1
      user1_notification2
      user1_notification3
      user1_notification4
      user2_notification1
      user2_notification2
    end

    subject { get :notifications, user_nickname: user1.nickname}

    it 'そのユーザーへの通知情報が、登録日時降順で返ってくること' do
      subject
      expect(assigns(:notifications)).to eq([user1_notification4, user1_notification3, user1_notification2, user1_notification1])
      expect(assigns(:notifications)[1].watering).to eq(watering2)
      expect(assigns(:notifications)[2].watering).to eq(watering1)
      expect(assigns(:notification_count)).to be_zero
    end

    it '通知情報を返した後、未読だった通知は全て既読になっていること' do
      subject
      expect(Notification.find(user1_notification2.id).read).to be_truthy
      expect(Notification.find(user1_notification3.id).read).to be_truthy
    end
  end
end
