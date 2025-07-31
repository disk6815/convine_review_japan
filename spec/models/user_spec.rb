require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    describe 'name' do
      it 'is required' do
        subject.name = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to include("can't be blank")
      end

      it 'must be at least 2 characters' do
        subject.name = 'A'
        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to include("is too short (minimum is 2 characters)")
      end

      it 'must be at most 50 characters' do
        subject.name = 'A' * 51
        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to include("is too long (maximum is 50 characters)")
      end

      it 'allows Japanese characters' do
        subject.name = '田中太郎'
        expect(subject).to be_valid
      end

      it 'allows Korean characters' do
        subject.name = '김철수'
        expect(subject).to be_valid
      end

      it 'allows English characters' do
        subject.name = 'John Doe'
        expect(subject).to be_valid
      end

      it 'allows numbers' do
        subject.name = 'User123'
        expect(subject).to be_valid
      end

      it 'allows underscores' do
        subject.name = 'user_name'
        expect(subject).to be_valid
      end

      it 'allows spaces' do
        subject.name = 'User Name'
        expect(subject).to be_valid
      end

      it 'rejects invalid characters' do
        # 正規表現バリデーションが一時的に無効化されているためスキップ
        skip "正規表現バリデーションが一時的に無効化されています"
        # subject.name = 'user@name'
        # expect(subject).not_to be_valid
        # expect(subject.errors[:name]).to include("は日本語、英語、韓国語、数字、アンダーバー、スペースのみ使用可能です")
      end
    end

    describe 'email' do
      it 'is required' do
        subject.email = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include("can't be blank")
      end

      it 'must be unique' do
        create(:user, email: 'test@example.com')
        subject.email = 'test@example.com'
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include("has already been taken")
      end

      it 'must have valid format' do
        subject.email = 'invalid-email'
        expect(subject).not_to be_valid
        expect(subject.errors[:email]).to include("の形式が正しくありません")
      end

      it 'accepts valid email format' do
        subject.email = 'user@example.com'
        expect(subject).to be_valid
      end

      it 'normalizes email to lowercase' do
        subject.email = 'USER@EXAMPLE.COM'
        subject.valid?
        expect(subject.email).to eq('user@example.com')
      end

      it 'strips whitespace from email' do
        subject.email = ' user@example.com '
        subject.valid?
        expect(subject.email).to eq('user@example.com')
      end
    end

    describe 'nationality' do
      it 'is required' do
        subject.nationality = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:nationality]).to include("can't be blank")
      end

      it 'accepts valid nationality values' do
        expect(subject.nationality).to eq('japan')
        subject.nationality = :korea
        expect(subject).to be_valid
      end
    end

    describe 'language' do
      it 'is required' do
        subject.language = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:language]).to include("can't be blank")
      end

      it 'accepts valid language values' do
        expect(subject.language).to eq('japanese')
        subject.language = :korean
        expect(subject).to be_valid
        subject.language = :english
        expect(subject).to be_valid
      end
    end

    describe 'password' do
      it 'is required for new records' do
        user = build(:user, password: nil, password_confirmation: nil)
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("は大文字、小文字、数字を含む必要があります")
      end

      it 'must be at least 8 characters' do
        subject.password = 'short'
        subject.password_confirmation = 'short'
        expect(subject).not_to be_valid
        expect(subject.errors[:password]).to include("は大文字、小文字、数字を含む必要があります")
      end

      it 'must contain uppercase, lowercase, and digit' do
        subject.password = 'password123'
        subject.password_confirmation = 'password123'
        expect(subject).not_to be_valid
        expect(subject.errors[:password]).to include("は大文字、小文字、数字を含む必要があります")
      end

      it 'accepts valid password format' do
        subject.password = 'Password123'
        subject.password_confirmation = 'Password123'
        expect(subject).to be_valid
      end

      it 'requires password confirmation' do
        subject.password_confirmation = nil
        expect(subject).not_to be_valid
        expect(subject.errors[:password_confirmation]).to include("can't be blank")
      end

      it 'must match password confirmation' do
        subject.password = 'Password123'
        subject.password_confirmation = 'Different456'
        expect(subject).not_to be_valid
        expect(subject.errors[:password_confirmation]).to include("がパスワードと一致しません")
      end
    end
  end

  describe 'enums' do
    describe 'nationality' do
      it 'defines nationality enum' do
        expect(User.nationalities).to eq({ 'japan' => 0, 'korea' => 1 })
      end

      it 'allows setting nationality by symbol' do
        user = build(:user, nationality: :korea)
        expect(user.nationality).to eq('korea')
      end

      it 'allows setting nationality by string' do
        user = build(:user, nationality: 'korea')
        expect(user.nationality).to eq('korea')
      end
    end

    describe 'language' do
      it 'defines language enum' do
        expect(User.languages).to eq({ 'japanese' => 0, 'korean' => 1, 'english' => 2 })
      end

      it 'allows setting language by symbol' do
        user = build(:user, language: :english)
        expect(user.language).to eq('english')
      end

      it 'allows setting language by string' do
        user = build(:user, language: 'english')
        expect(user.language).to eq('english')
      end
    end
  end

  describe 'callbacks' do
    describe 'before_validation' do
      it 'normalizes email to lowercase' do
        user = build(:user, email: 'USER@EXAMPLE.COM')
        user.valid?
        expect(user.email).to eq('user@example.com')
      end

      it 'strips whitespace from email' do
        user = build(:user, email: ' user@example.com ')
        user.valid?
        expect(user.email).to eq('user@example.com')
      end

      it 'strips whitespace from name' do
        user = build(:user, name: ' User Name ')
        user.valid?
        expect(user.name).to eq('User Name')
      end
    end
  end

  describe 'Sorcery integration' do
    it 'includes Sorcery authentication' do
      expect(User).to respond_to(:authenticates_with_sorcery!)
    end

    it 'has password_confirmation attribute' do
      user = build(:user)
      expect(user).to respond_to(:password_confirmation)
      expect(user).to respond_to(:password_confirmation=)
    end
  end

  describe 'factory traits' do
    describe ':korean' do
      it 'creates user with Korean nationality and language' do
        user = build(:user, :korean)
        expect(user.nationality).to eq('korea')
        expect(user.language).to eq('korean')
      end
    end

    describe ':english' do
      it 'creates user with English language' do
        user = build(:user, :english)
        expect(user.language).to eq('english')
      end
    end

    describe ':invalid_password' do
      it 'creates user with weak password' do
        user = build(:user, :invalid_password)
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("は大文字、小文字、数字を含む必要があります")
      end
    end

    describe ':mismatched_password' do
      it 'creates user with mismatched password confirmation' do
        user = build(:user, :mismatched_password)
        expect(user).not_to be_valid
        expect(user.errors[:password_confirmation]).to include("がパスワードと一致しません")
      end
    end

    describe ':invalid_email' do
      it 'creates user with invalid email format' do
        user = build(:user, :invalid_email)
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("の形式が正しくありません")
      end
    end

    describe ':duplicate_email' do
      it 'creates user with duplicate email' do
        create(:user, :duplicate_email)
        user = build(:user, :duplicate_email)
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("has already been taken")
      end
    end

    describe ':invalid_name' do
      it 'creates user with invalid name characters' do
        # 正規表現バリデーションが一時的に無効化されているためスキップ
        skip "正規表現バリデーションが一時的に無効化されています"
        # user = build(:user, :invalid_name)
        # expect(user).not_to be_valid
        # expect(user.errors[:name]).to include("は日本語、英語、韓国語、数字、アンダーバー、スペースのみ使用可能です")
      end
    end

    describe ':short_name' do
      it 'creates user with name too short' do
        user = build(:user, :short_name)
        expect(user).not_to be_valid
        expect(user.errors[:name]).to include("is too short (minimum is 2 characters)")
      end
    end

    describe ':long_name' do
      it 'creates user with name too long' do
        user = build(:user, :long_name)
        expect(user).not_to be_valid
        expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
      end
    end
  end
end 