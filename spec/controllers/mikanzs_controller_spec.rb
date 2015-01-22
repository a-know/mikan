# encoding: utf-8

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

  describe 'POST#create' do
    before { @params = attributes_for(:mikanz) }
    subject { post :create, mikanz: @params }

    context 'when user not logged in accessed' do
      it 'redirect to top' do
        subject
        expect(response).to redirect_to(root_path)
      end
    end
    context 'params are all correctly and save successful' do
      before do
        user = create(:user)
        session[:user_id] = user.id
      end

      it 'return 200 as status code' do
        expect(response.status).to eq(200)
      end

      it 'redirect to  `show` page' do
        subject
        saved_mikanz = Mikanz.find_by(name: @params[:name])
        expect(response).to redirect_to(mikanz_url(id: saved_mikanz.id))
      end

      it 'set a saved object to @mikanz' do
        subject
        expect(assigns(:mikanz).errors).to be_empty
        expect(assigns(:mikanz)).to be_persisted
        expect(assigns(:mikanz).name).to eq(@params[:name])
      end

      it 'create mikanz in DB successfuly' do
        expect do
          subject
          response
        end.to change{ Mikanz.count }.by(1)
      end
    end
  end

  describe 'GET #edit' do
    before do
      @mikanz = create(:mikanz)
      session[:user_id] = @mikanz.owner.id
    end
    subject { get :edit, id: @mikanz.id }

    it 'return 200 OK' do
      subject
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'パラメータで渡された id に対応する mikanz オブジェクトを @mikanz にセットする' do
      subject
      expect(assigns(:mikanz)).to eq(@mikanz)
    end

    it 'render `edit` template' do
      subject
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    context 'params are all correctly and save successful' do
      before do
        @mikanz = create(:mikanz)
        session[:user_id] = @mikanz.owner.id
      end
      subject { put :update, id: @mikanz.id, mikanz: { name: "変更後", start_time: @mikanz.start_time, content: @mikanz.content} }

      it 'return 200 as status code' do
        expect(response.status).to eq(200)
      end

      it 'redirect to `show` page' do
        subject
        expect(response).to redirect_to(mikanz_url(id: @mikanz.id))
      end

      it 'set a saved object to @mikanz' do
        subject
        expect(assigns(:mikanz).errors).to be_empty
        expect(assigns(:mikanz)).to be_persisted
        expect(assigns(:mikanz).name).to eq('変更後')
      end

      it 'DB内のレコードが更新されていること' do
        subject
        expect(Mikanz.find(@mikanz.id).name).to eq('変更後')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @mikanz = create(:mikanz)
      session[:user_id] = @mikanz.owner.id
    end
    subject { delete :destroy, id: @mikanz.id }

    it 'redirect to top' do
      subject
      expect(response).to redirect_to(root_path)
    end

    it 'expect to delete the mikan' do
      expect do
        subject
        response
      end.to change{ Mikanz.count }.by(-1)
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

      it 'return 200 OK' do
        expect(response).to be_success
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
