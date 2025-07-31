class User < ApplicationRecord
  authenticates_with_sorcery!

  # Sorcery virtual attributes
  attr_accessor :password_confirmation

  # Enums
  enum nationality: {
    japan: 0,
    korea: 1
  }

  enum language: {
    japanese: 0,
    korean: 1,
    english: 2
  }

  # Validations
  validates :name, presence: true, length: { maximum: 50, minimum: 2 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nationality, presence: true
  validates :language, presence: true
  
  # Password validations (Sorcery)
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, format: { 
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/, 
    message: "は大文字、小文字、数字を含む必要があります" 
  }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validate :password_confirmation_match, if: -> { new_record? || changes[:crypted_password] }
  
  # Email format validation
  validates :email, format: { 
    with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
    message: "の形式が正しくありません" 
  }
  
  # Name format validation
  validates :name, format: { 
    with: /\A[ぁ-んァ-ヶー가-힣a-zA-Z0-9_\s]+\z/,
    message: "は日本語、英語、韓国語、数字、アンダーバー、スペースのみ使用可能です" 
  }

  # Callbacks
  before_validation :normalize_email
  before_validation :normalize_name

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def normalize_name
    self.name = name.strip if name.present?
  end

  def password_confirmation_match
    return if password.blank? || password_confirmation.blank?
    
    unless password == password_confirmation
      errors.add(:password_confirmation, "がパスワードと一致しません")
    end
  end
end
