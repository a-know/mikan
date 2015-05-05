require 'rails_helper'

RSpec.describe TopController, :type => :controller do
  describe '#index' do
    before do
      @mikanz1 = create(:mikanz)
      @mikanz2 = create(:mikanz)
      @mikanz3 = create(:mikanz)
      @mikanz4 = create(:mikanz)
      @mikanz5 = create(:mikanz)
      get :index
    end

    it 'set a new Array<Mikanz> object to @mikanzs' do
      expect(assigns(:mikanzs).size).to eq(3)
      expect(assigns(:mikanzs).first.id).to eq(@mikanz5.id)
      expect(assigns(:mikanzs).last.id).to eq(@mikanz3.id)
    end
  end
end
