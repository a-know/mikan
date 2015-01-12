# encoding: utf-8

require 'rails_helper'

describe 'a user logged in to register event or take a tickets' do
  context 'when click "Twitterでログイン" on top page' do
    context 'when success to Twitter login' do
      before do
        visit root_path
        click_link 'Twitter でログイン'
      end

      it 'rendered top page' do
        expect(page.current_path).to eq root_path
      end

      it 'show "ログインしました"' do
        expect(page).to have_content 'ログインしました'
      end

      context 'when click "ログアウト" on top page' do
        before { click_link 'ログアウト' }

        it 'rendered top page' do
          expect(page.current_path).to eq root_path
        end
        it 'show "ログアウトしました"' do
          expect(page).to have_content 'ログアウトしました'
        end
      end
    end
  end
end