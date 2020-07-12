FactoryBot.define do
  factory :item do
    id              {1}
    name            {"シャツ"}
    introduce       {"ユニクロのシャツです"}
    brand           {"ユニクロ"}
    condition_id    {1}
    prefecture_id   {1}
    preparation_id  {1}
    price           {1}
    category
    delivery
    saler_id         {1}  
    after(:build) do |item|
      item.images << build(:image, item: item)
    end
  end
end