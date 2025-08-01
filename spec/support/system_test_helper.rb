module SystemTestHelper
  def login_as(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'Password123'
    click_button 'ログイン'
  end

  def signup_user(attributes = {})
    visit signup_path
    fill_in '名前', with: attributes[:name] || 'Test User'
    fill_in 'メールアドレス', with: attributes[:email] || 'test@example.com'
    select attributes[:nationality] || '日本', from: '国籍'
    select attributes[:language] || '日本語', from: '言語'
    fill_in 'パスワード', with: attributes[:password] || 'Password123'
    fill_in 'パスワード（確認）', with: attributes[:password_confirmation] || 'Password123'
    click_button '登録'
  end

  def expect_flash_message(message, type: :notice)
    expect(page).to have_content(message)
  end

  def expect_error_message(message)
    expect(page).to have_content(message)
  end
end

RSpec.configure do |config|
  config.include SystemTestHelper, type: :system
end
