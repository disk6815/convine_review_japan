FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "Password123" }
    password_confirmation { "Password123" }
    nationality { :japan }
    language { :japanese }

    trait :korean do
      nationality { :korea }
      language { :korean }
    end

    trait :english do
      language { :english }
    end

    trait :invalid_password do
      password { "weak" }
      password_confirmation { "weak" }
    end

    trait :mismatched_password do
      password { "Password123" }
      password_confirmation { "Different456" }
    end

    trait :invalid_email do
      email { "invalid-email" }
    end

    trait :duplicate_email do
      email { "duplicate@example.com" }
    end

    trait :invalid_name do
      name { "User@123" } # 特殊文字を含む
    end

    trait :short_name do
      name { "A" } # 最小文字数未満
    end

    trait :long_name do
      name { "A" * 51 } # 最大文字数超過
    end
  end
end
