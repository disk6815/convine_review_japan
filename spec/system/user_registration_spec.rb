require 'rails_helper'

RSpec.describe 'User Registration', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  describe '新規登録ページ' do
    it '新規登録ページにアクセスできる' do
      visit signup_path
      expect(page).to have_content('新規登録')
      expect(page).to have_field('名前')
      expect(page).to have_field('メールアドレス')
      expect(page).to have_field('国籍')
      expect(page).to have_field('言語')
      expect(page).to have_field('パスワード')
      expect(page).to have_field('パスワード（確認）')
    end

    it '有効な情報で新規登録できる' do
      visit signup_path
      
      fill_in '名前', with: '田中太郎'
      fill_in 'メールアドレス', with: 'tanaka@example.com'
      select '日本', from: '国籍'
      select '日本語', from: '言語'
      fill_in 'パスワード', with: 'Password123'
      fill_in 'パスワード（確認）', with: 'Password123'
      
      click_button '登録'
      
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('アカウントが正常に作成されました')
      expect(page).to have_content('田中太郎')
    end

    it '無効な情報で新規登録するとエラーが表示される' do
      visit signup_path
      
      fill_in '名前', with: ''
      fill_in 'メールアドレス', with: 'invalid-email'
      fill_in 'パスワード', with: 'weak'
      fill_in 'パスワード（確認）', with: 'different'
      
      click_button '登録'
      
      expect(page).to have_content('新規登録')
      expect(page).to have_content("can't be blank")
      expect(page).to have_content('の形式が正しくありません')
      expect(page).to have_content('は大文字、小文字、数字を含む必要があります')
      expect(page).to have_content('がパスワードと一致しません')
    end

    it '重複したメールアドレスで登録するとエラーが表示される' do
      create(:user, email: 'existing@example.com')
      
      visit signup_path
      
      fill_in '名前', with: '田中太郎'
      fill_in 'メールアドレス', with: 'existing@example.com'
      select '日本', from: '国籍'
      select '日本語', from: '言語'
      fill_in 'パスワード', with: 'Password123'
      fill_in 'パスワード（確認）', with: 'Password123'
      
      click_button '登録'
      
      expect(page).to have_content('新規登録')
      expect(page).to have_content('has already been taken')
    end

    it 'パスワードが短すぎる場合エラーが表示される' do
      visit signup_path
      
      fill_in '名前', with: '田中太郎'
      fill_in 'メールアドレス', with: 'tanaka@example.com'
      select '日本', from: '国籍'
      select '日本語', from: '言語'
      fill_in 'パスワード', with: 'short'
      fill_in 'パスワード（確認）', with: 'short'
      
      click_button '登録'
      
      expect(page).to have_content('新規登録')
      expect(page).to have_content('は大文字、小文字、数字を含む必要があります')
    end

    it 'パスワードに大文字が含まれていない場合エラーが表示される' do
      visit signup_path
      
      fill_in '名前', with: '田中太郎'
      fill_in 'メールアドレス', with: 'tanaka@example.com'
      select '日本', from: '国籍'
      select '日本語', from: '言語'
      fill_in 'パスワード', with: 'password123'
      fill_in 'パスワード（確認）', with: 'password123'
      
      click_button '登録'
      
      expect(page).to have_content('新規登録')
      expect(page).to have_content('は大文字、小文字、数字を含む必要があります')
    end

    it '韓国語で登録できる' do
      visit signup_path
      
      fill_in '名前', with: '김철수'
      fill_in 'メールアドレス', with: 'kim@example.com'
      select '韓国', from: '国籍'
      select '韓国語', from: '言語'
      fill_in 'パスワード', with: 'Password123'
      fill_in 'パスワード（確認）', with: 'Password123'
      
      click_button '登録'
      
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('アカウントが正常に作成されました')
      expect(page).to have_content('김철수')
    end

    it '英語で登録できる' do
      visit signup_path
      
      fill_in '名前', with: 'John Doe'
      fill_in 'メールアドレス', with: 'john@example.com'
      select '日本', from: '国籍'
      select '英語', from: '言語'
      fill_in 'パスワード', with: 'Password123'
      fill_in 'パスワード（確認）', with: 'Password123'
      
      click_button '登録'
      
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('アカウントが正常に作成されました')
      expect(page).to have_content('John Doe')
    end
  end

  describe 'ナビゲーション' do
    it '新規登録ページからログインページにリンクできる' do
      visit signup_path
      click_link 'ログイン'
      expect(page).to have_current_path(login_path)
      expect(page).to have_content('ログイン')
    end

    it '新規登録ページからTOPページに戻れる' do
      visit signup_path
      click_link 'TOPへ'
      expect(page).to have_current_path(root_path)
    end
  end
end 