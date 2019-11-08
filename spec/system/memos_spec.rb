require 'rails_helper'

describe 'メモ管理機能', type: :system do
  # ユーザーＡを作成しておく
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーＡ', email: 'a@example.com') }
  # ユーザーＢを作成しておく
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーＢ', email: 'b@example.com') }
  # 作成者がユーザーＡであるメモを作成しておく
  let!(:memo_a) { FactoryBot.create(:memo, title: '最初のメモ', user: user_a) }

  before do
    # ログイン
    visit login_path
    # fill_in 'メールアドレス', with: 'a@example.com'
    fill_in 'メールアドレス', with: login_user.email
    # fill_in 'パスワード', with: 'password'
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end
  
  shared_examples_for 'ユーザーＡが作成したメモが表示される' do
    # 作成済みのメモのタイトルが画面上に表示されている事を確認
    it { expect(page).to have_content '最初のメモ' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      # before do
        # ユーザーＡでログインする
        # visit login_path
        # fill_in 'メールアドレス', with: 'a@example.com'
        # fill_in 'パスワード', with: 'password'
        # click_button 'ログインする'
      # end
      let(:login_user) { user_a }

      # it 'ユーザーＡが作成したメモが表示される' do
      #   # 作成済みのメモのタイトルが画面上に表示されている事を確認
      #   expect(page).to have_content '最初のメモ'
      # end

      it_behaves_like 'ユーザーＡが作成したメモが表示される'
    end
    
    context 'ユーザーＢがログインしている時' do
      # before do
      # ユーザーＢを作成しておく
      # FactoryBot.create(:user, name: 'ユーザーＢ', email: 'b@example.com')
        # ユーザーＢでログインする
        # visit login_path
        # fill_in 'メールアドレス', with: 'b@example.com'
        # fill_in 'パスワード', with: 'password'
        # click_button 'ログインする'
        # end
        let(:login_user) { user_b }
        
      it 'ユーザーＡが作成したメモが表示されない' do
        # ユーザーＡが作成したメモのタイトルが画面上に表示されていない事を確認
        expect(page).to have_no_content '最初のメモ'
      end
    end
  end
  
  describe '詳細表示機能' do
    context 'ユーザーＡがログインしている時' do
      let(:login_user) { user_a }
      
      before do
        visit memo_path(memo_a)
      end
      
      # it 'ユーザーＡが作成したメモが表示される' do
      #   expect(page).to have_content '最初のメモ'
      # end
      it_behaves_like 'ユーザーＡが作成したメモが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_memo_path
      fill_in 'タイトル', with: memo_title
      click_button '登録する'
    end

    context '新規登録画面でタイトルを入力した時' do
      let(:memo_title) { '新規作成のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面でタイトルを入力しなかった時' do
      let(:memo_title) { ' ' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end
  end
end