require 'rails_helper'

RSpec.describe TopController, :type => :controller do
  describe '#index' do
    before do
      @mikanz1 = create(:mikanz, tag_list: 'A,B,C')
      @mikanz2 = create(:mikanz, tag_list: 'A,B')
      @mikanz3 = create(:mikanz, tag_list: 'A')
      @mikanz4 = create(:mikanz, tag_list: 'D')
      @mikanz5 = create(:mikanz, tag_list: 'E,F')
      get :index
    end

    it 'set a new Array<Mikanz> object to @mikanzs' do
      expect(assigns(:mikanzs).size).to eq(4)
      expect(assigns(:mikanzs).first.id).to eq(@mikanz5.id)
      expect(assigns(:mikanzs).last.id).to eq(@mikanz2.id)
      expect(assigns(:tags).size).to eq(6)
      expect(assigns(:tags).first.name).to eq('A')
      expect(assigns(:tags).first.taggings_count).to eq(3)
      expect(assigns(:tags).last.name).to eq('F')
      expect(assigns(:tags).last.taggings_count).to eq(1)
    end
  end
end
