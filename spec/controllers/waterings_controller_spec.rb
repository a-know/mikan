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

    it '水やり（応援）が正常に記録されること' do
      # そのユーザーに紐付く watering となっているかの確認
      expect do
        subject
      end.to change { User.find(@user.id).waterings.size }.by(1)
      # あるミカンに紐付く watering がそのユーザーのものかを確認
      expect(Watering.find_by(mikanz_id: @mikanz.id).user_id).to eq(@user.id)
    end
    it 'return 201 as status code' do
      subject
      expect(response.status).to eq(201)
    end
  end
end
