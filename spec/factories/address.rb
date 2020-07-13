FactoryBot.define do
  factory :address do
    destination_last_name        {"田中"}
    destination_first_name          {"太郎"}
    destination_last_name_kana       {"タナカ"}
    destination_first_name_kana        {"タロウ"}
    post_code                    {"1234567"}
    prefecture_id                 {"1"}
    city                         {"丸の内"}
    address                     {"1"}
  end
end