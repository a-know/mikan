# encoding: utf-8

require 'rails_helper'

describe 'ユーザが応援をする', js: true do
  let!(:mikanz) { create :mikanz }

  context 'ログインユーザが、ミカン詳細ページで"応援する"をクリックしたとき' do
    before do
      visit root_path
      click_link 'Twitter でログイン'
      visit mikanz_path(mikanz)
      click_on '応援する'
    end

    it '"応援を完了しました"と表示されていること' do
      expect(page).to have_content('応援を完了しました')
    end

    xit '応援したユーザー名が表示されていること' do
      expect(page).to have_content('@a-know')
    end

    xcontext 'その後、その応援をキャンセルしたとき' do
      before do
        click_on '応援を取り消す'
      end

      it '"このミカンへの応援を取り消しました"と表示されていること' do
        expect(page).to have_content('このミカンへの応援を取り消しました')
      end

      it '応援したユーザー名が表示されていないこと' do
        expect(page).to_not have_content('@a-know')
      end
    end
  end
end