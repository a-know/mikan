# encoding: utf-8

require 'rails_helper'

RSpec.describe WateringsController, type: :controller do
  describe '#new' do
    subject { get :new, :mikanz_id => @mikanz.id }
    context 'ログイン状態で WateringsController#new にアクセス' do
      before do
        @mikanz = create(:mikanz)
        user = create(:user)
        session[:user_id] = user.id
      end
      it 'ActionController::RoutingError がスローされること' do
        expect do
          subject
        end.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe '#create' do
    before do
      @mikanz = create(:mikanz)
      @user = create(:user)
      session[:user_id] = @user.id
    end
    subject { post :create, :mikanz_id => @mikanz }

    context '水やり対象ミカンのオーナーとログインユーザーが異なる場合' do
      before do
        @mikanz = create(:mikanz)
        @user = create(:user)
        session[:user_id] = @user.id
      end
      it '水やり（応援）が正常に記録されること' do
        # そのユーザーに紐付く watering となっているかの確認
        expect do
          subject
        end.to change { User.find(@user.id).waterings.size }.by(1)
        # あるミカンに紐付く watering がそのユーザーのものかを確認
        expect(Watering.find_by(mikanz_id: @mikanz.id).user_id).to eq(@user.id)
      end
      it 'ミカン主への通知情報が正常に記録されること' do
        expect do
          subject
        end.to change { User.find(@mikanz.owner.id).notifications.size }.by(1)
      end
      it 'return 201 as status code' do
        subject
        expect(response.status).to eq(201)
      end
    end
    context '水やり対象ミカンのオーナーとログインユーザーが同じ場合' do
      before do
        @mikanz = create(:mikanz)
        session[:user_id] = @mikanz.owner.id
      end
      it 'エラーとなること' do
        expect do
          subject
        end.to raise_error(ActionController::RoutingError, '自分のミカンを自分で応援することはできません')
      end
    end
  end

  describe '#destroy' do
    before do
      @watering = create(:watering)
      @mikanz = @watering.mikanz
      @user = @watering.user
      session[:user_id] = @user.id
    end
    subject { delete :destroy, :mikanz_id => @mikanz.id, :id => @watering.id }

    it '削除が正しく行われていること' do
      expect do
        subject
      end.to change{ Watering.count }.by(-1)
      expect(Watering.find_by(mikanz_id: @mikanz.id)).to be_nil
    end

    it '削除完了後、当該ミカンページにリダイレクトすること' do
      subject
      expect(response).to redirect_to(mikanz_path(@mikanz.id))
    end
  end
end
