# encoding: utf-8

require 'rails_helper'

describe 'ユーザが水やり（応援）をする', js: true do
  let!(:mikanz) { create :mikanz }

  context 'ログインユーザが、ミカン詳細ページで"水やり（応援）する"をクリックしたとき' do
    before do
      visit root_path
      click_link 'Twitter でログイン'
      visit mikanz_path(mikanz)
      click_on '水やり（応援）する'
    end

    it '"水やり（応援）を完了しました"と表示されていること' do
      expect(page).to have_content('水やり（応援）を完了しました')
    end

    it '参加表明したユーザ名が表示されていること' do
      expect(page).to have_content('@a-know')
    end
  end
end