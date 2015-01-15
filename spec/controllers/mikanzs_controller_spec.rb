require 'rails_helper'

RSpec.describe MikanzsController, :type => :controller do

  describe 'GET #new' do
    context 'when user not logged in accessed' do
      before { get :new }

      it 'redirect to top' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user logged in accessed' do
      before do
        user = create(:user)
        session[:user_id] = user.id
        get :new
      end

      it 'return 200 as status code' do
        expect(response.status).to eq(200)
      end

      it 'set a new Mikanz object to @mikanz' do
        expect(assigns(:mikanz)).to be_a_new(Mikanz)
      end

      it 'render `new` template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    context 'when specified id which does not saved' do
      before { get :show, id: 99999 }

      it 'return 404 as status code' do
        expect(response.status).to eq(404)
      end
    end
    context 'when specified id is exists' do
      before do
        @mikanz = create(:mikanz)
        get :show, id: @mikanz.id
      end

      it 'return 200 as status code' do
        expect(response.status).to eq(200)
      end

      it 'set a find result object to @mikanz' do
        expect(assigns(:mikanz)).to eq(@mikanz)
      end

      it 'render `show` template' do
        expect(response).to render_template :show
      end
    end
  end

end
