FactoryBot.define do
  factory :user do  
    nickname          {"sasa"}
    email             {"kkk@gmail.com"}
    password          {"00000000"}  
    encrypted_password{"00000000"}
    last_name       {"sasaki"}
    first_name        {"goro"}
    last_name_kana  {"sasaki"}
    first_name_kana   {"goro"}
    birthday         {"1990-08-24"}
  end
end
