require 'rails_helper'

RSpec.describe "ユーザー登録", type: :system do

  before do
    driven_by(:rack_test)
  end

  describe 'タイトルの動的表示' do
    context 'ユーザー登録画面の場合' do
      it '正しくタイトルが表示される' do
        
      end
    end
  end

  describe 'ユーザーの作成について' do
    context '入力が正常である' do
      it 'ユーザーの新規作成ができること' do
        visit '/users/new'
        expect{
          fill_in '名前', with: 'テスト太郎'
          fill_in 'メールアドレス', with: 'example@example.com'
          fill_in 'パスワード(6文字以上)', with: '12345678'
          fill_in 'パスワードもう一度', with: '12345678'
          click_button '登録する'
          Capybara.assert_current_path("/", ignore_query: true)
        }.to change { User.count }.by(1)
        expect(page).to have_content('登録できました'), 'フラッシュメッセージ「登録できました」が表示されていません'
      end
    end

    context '入力が正常でない' do
      it '新規作成に失敗する' do
        visit '/users/new'
        expect{
          click_button '登録する'
      }.to change { User.count }.by(0)
        expect(page).to have_content('登録できませんでした'), 'フラッシュメッセージ「登録できませんでした」が表示されていません'
        expect(page).to have_content('名前を入力してください'), 'フラッシュメッセージ「名前を入力してください」が表示されていません'
        expect(page).to have_content('メールアドレスを入力してください'), 'フラッシュメッセージ「メールアドレスを入力してください」が表示されていません'
        expect(page).to have_content('パスワードは6文字以上で入力してください'), 'フラッシュメッセージ「パスワードは6文字以上で入力してください」が表示されていません'
        expect(page).to have_content('パスワード(もう一度)'), 'フラッシュメッセージ「パスワード(もう一度)」が表示されていません'
      end
    end
  end
end
