FactoryBot.define do
  factory :user do  
    nickname          {"sasa"}
    email             {"kkk@gmail.com"}
    password          {"00000000"}  
    encrypted_password{"00000000"}
    last_name       {"平野"}
    first_name        {"達也"}
    last_name_kana  {"ヒラノ"}
    first_name_kana   {"タツヤ"}
    birthday         {"1990-08-24"}
  end
end
