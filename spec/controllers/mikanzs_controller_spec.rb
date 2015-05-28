# encoding: utf-8

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

      it 'redirect to `show` page' do
        subject
        saved_mikanz = Mikanz.find_by(name: @params[:name])
        expect(response).to redirect_to(mikanz_url(id: saved_mikanz.id))
      end

      it 'set a saved object to @mikanz' do
        subject
        expect(assigns(:mikanz).errors).to be_empty
        expect(assigns(:mikanz)).to be_persisted
        expect(assigns(:mikanz).name).to eq(@params[:name])
        expect(assigns(:mikanz).completion).to eq(@params[:completion])
        expect(assigns(:mikanz).tag_list).to eq(@params[:tag_list].split(','))
        expect(assigns(:mikanz).start_year).to eq(@params[:start_year])
        expect(assigns(:mikanz).start_month).to eq(@params[:start_month])
        expect(assigns(:mikanz).url).to eq(@params[:url])
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
      subject do
        put :update,
          id: @mikanz.id,
          mikanz: {
            name: "変更後",
            content: @mikanz.content,
            tag_list: '鉄細工,DIY',
            start_year: 1982,
            start_month: 3,
            url: 'http://blog.a-know.me/',
            completion: 'motivation',
          }
      end

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
        expect(assigns(:mikanz).tag_list).to eq(['鉄細工', 'DIY'])
        expect(assigns(:mikanz).start_year).to eq(1982)
        expect(assigns(:mikanz).start_month).to eq(3)
        expect(assigns(:mikanz).url).to eq('http://blog.a-know.me/')
        expect(assigns(:mikanz).completion).to eq('motivation')
      end

      it 'DB内のレコードが更新されていること' do
        subject
        expect(Mikanz.find(@mikanz.id).name).to eq('変更後')
      end
    end

    context '完成度が「完成した！」に更新されたとき' do
      context '当該ミカンを応援した人がいる場合' do
        before do
          @watering = create(:watering)
          @mikanz = @watering.mikanz
          session[:user_id] = @mikanz.owner.id
        end
        subject do
          put :update,
            id: @mikanz.id,
            mikanz: {
              name: "変更後",
              content: @mikanz.content,
              tag_list: '鉄細工,DIY',
              start_year: 1982,
              start_month: 3,
              url: 'http://blog.a-know.me/',
              completion: 'complete',
            }
        end

        it 'notification レコードが作成されていること' do
          expect {
            subject
          }.to change { User.find(@watering.user.id).notifications.size }.by(1)
        end
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
      subject { get :show, id: 99999 }

      it 'return 404 as status code' do
        subject
        expect(response.status).to eq(404)
      end
    end
    context 'when specified id is exists' do
      before do
        @watering = create(:watering)
        @mikanz = @watering.mikanz
        @user = @watering.user
      end
      subject { get :show, id: @mikanz.id }

      it 'return 200 OK' do
        subject
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      context '水やりした本人ではないユーザーが閲覧しているとき' do
        it 'set a find result object to @mikanz and @waterings' do
          subject
          expect(assigns(:mikanz)).to eq(@mikanz)
          expect(assigns(:watering)).to be_nil
          expect(assigns(:waterings)).to eq(@mikanz.waterings)
        end
      end
      context '水やりした本人であるユーザーが閲覧しているとき' do
        before { session[:user_id] = @user.id }
        it 'set a find result object to @mikanz and @waterings' do
          subject
          expect(assigns(:mikanz)).to eq(@mikanz)
          expect(assigns(:watering)).to eq(@user.waterings.find_by(mikanz_id: @mikanz.id))
          expect(assigns(:waterings)).to eq(@mikanz.waterings)
        end
      end

      it 'render `show` template' do
        subject
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #tag_search' do
    let(:mikanz1) { create(:mikanz, tag_list: 'aaa,bbb') }
    let(:mikanz2) { create(:mikanz, tag_list: 'aaa,ccc') }
    let(:mikanz3) { create(:mikanz, tag_list: 'ddd') }
    before do
      mikanz1
      mikanz2
      mikanz3
    end
    context 'when specified tag_name which exists' do
      subject { get :tag_search, tag_name: 'aaa', page: 1 }

      it 'set a find result object to @tag_name and @mikanzs' do
        subject
        expect(assigns(:tag_name)).to eq('aaa')
        expect(assigns(:mikanzs)).to eq([mikanz1, mikanz2])
      end
    end

    context 'when specified tag_name which does not exists' do
      subject { get :tag_search, tag_name: 'eee', page: 1 }

      it 'set a tag_name to @tag_name and empty array to @mikanzs' do
        subject
        expect(assigns(:tag_name)).to eq('eee')
        expect(assigns(:mikanzs)).to eq([])
      end
    end
  end

  describe 'GET #users_mikanzs' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:mikanz1) { create(:mikanz, owner: user1) }
    let(:mikanz2) { create(:mikanz, owner: user2) }
    let(:mikanz3) { create(:mikanz, owner: user1) }
    let(:mikanz4) { create(:mikanz, owner: user2) }
    let(:mikanz5) { create(:mikanz, owner: user1) }
    before do
      mikanz1
      mikanz2
      mikanz3
      mikanz4
      mikanz5
    end

    context 'when specifed user_nickname which has some mikanzs' do
      subject { get :users_mikanzs, user_nickname: user2.nickname, page: 1 }

      it 'set a find result object to @user_nickname and @mikanzs' do
        subject
        expect(assigns(:user)).to eq(user2)
        expect(assigns(:mikanzs)).to eq([mikanz4, mikanz2])
      end
    end

    context 'when specifed user_nickname which has no mikanzs' do
      subject { get :users_mikanzs, user_nickname: user3.nickname, page: 1 }

      it 'set a find result object to @user_nickname and empty array to @mikanzs' do
        subject
        expect(assigns(:user)).to eq(user3)
        expect(assigns(:mikanzs)).to eq([])
      end
    end
  end
end
