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
end
