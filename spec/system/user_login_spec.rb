require 'rails_helper'

RSpec.describe 'User Login', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:user) { create(:user, email: 'test@example.com', password: 'Password123') }

  describe 'ログインページ' do
    it 'ログインページにアクセスできる' do
      visit login_path
      expect(page).to have_content('ログイン')
      expect(page).to have_field('メールアドレス')
      expect(page).to have_field('パスワード')
    end

    it '有効な情報でログインできる' do
      user # ユーザーを作成
      
      visit login_path
      
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'Password123'
      
      click_button 'ログイン'
      
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('ログインしました')
      expect(page).to have_content('User1')
    end

    it '無効なメールアドレスでログインするとエラーが表示される' do
      user # ユーザーを作成
      
      visit login_path
      
      fill_in 'メールアドレス', with: 'wrong@example.com'
      fill_in 'パスワード', with: 'Password123'
      
      click_button 'ログイン'
      
      expect(page).to have_content('ログイン')
      expect(page).to have_content('メールアドレスまたはパスワードが正しくありません')
    end

    it '無効なパスワードでログインするとエラーが表示される' do
      user # ユーザーを作成
      
      visit login_path
      
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'wrongpassword'
      
      click_button 'ログイン'
      
      expect(page).to have_content('ログイン')
      expect(page).to have_content('メールアドレスまたはパスワードが正しくありません')
    end

    it '空のフィールドでログインするとエラーが表示される' do
      visit login_path
      
      click_button 'ログイン'
      
      expect(page).to have_content('ログイン')
      expect(page).to have_content('メールアドレスまたはパスワードが正しくありません')
    end
  end

  describe 'ログアウト' do
    it 'ログイン後にログアウトできる' do
      user # ユーザーを作成
      
      visit login_path
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'Password123'
      click_button 'ログイン'
      
      expect(page).to have_content('User1')
      
      click_button 'Logout'
      
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('ログアウトしました')
      expect(page).to have_content('Login')
      expect(page).to have_content('Sign up')
    end
  end

  describe '認証が必要なページ' do
    it 'ログインしていない状態でTOPページにアクセスするとログインページにリダイレクトされる' do
      visit root_path
      expect(page).to have_current_path(login_path)
      expect(page).to have_content('ログインが必要です')
    end

    it 'ログイン後にTOPページにアクセスできる' do
      user # ユーザーを作成
      
      visit login_path
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'Password123'
      click_button 'ログイン'
      
      visit root_path
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('User1')
    end
  end

  describe 'ナビゲーション' do
    it 'ログインページから新規登録ページにリンクできる' do
      visit login_path
      click_link '新規登録'
      expect(page).to have_current_path(signup_path)
      expect(page).to have_content('新規登録')
    end

    it 'ログインページからTOPページに戻れる' do
      visit login_path
      click_link 'TOPへ'
      expect(page).to have_current_path(root_path)
    end
  end

  describe 'ヘッダーの表示' do
    it 'ログイン前はヘッダーにLoginとSign upが表示される' do
      visit login_path
      expect(page).to have_content('Login')
      expect(page).to have_content('Sign up')
      expect(page).not_to have_content('Logout')
    end

    it 'ログイン後はヘッダーにユーザー名とLogoutが表示される' do
      user # ユーザーを作成
      
      visit login_path
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'Password123'
      click_button 'ログイン'
      
      expect(page).to have_content('User1')
      expect(page).to have_content('Logout')
      expect(page).not_to have_content('Login')
      expect(page).not_to have_content('Sign up')
    end
  end

  describe 'フラッシュメッセージ' do
    it 'ログイン成功時にフラッシュメッセージが表示される' do
      user # ユーザーを作成
      
      visit login_path
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'Password123'
      click_button 'ログイン'
      
      expect(page).to have_content('ログインしました')
    end

    it 'ログアウト時にフラッシュメッセージが表示される' do
      user # ユーザーを作成
      
      visit login_path
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'Password123'
      click_button 'ログイン'
      
      click_button 'Logout'
      
      expect(page).to have_content('ログアウトしました')
    end
  end
end 