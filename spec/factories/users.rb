FactoryBot.define do
  factory :user do  
    nickname          {"sasa"}
    email             {"kkk@gmail.com"}
    password          {"00000000"}  
    encrypted_password{"00000000"}
    last_name         {"田中"}
    first_name        {"太郎"}
    last_name_kana    {"タナカ"}
    first_name_kana   {"タロウ"}
    birthday         {"1990-08-24"}
  end
end
