FactoryBot.define do
  factory :item do
    name              {"ビール"}
    text              {"アルコール飲料です"}
    brand             {"アサヒ"}
    condition_id      {1}
    postage_payer_id  {2}
    prefecture_id     {16}
    preparation_id    {1} 
    price          {300}
    user
    category
    after(:build) do |item|
      item.item_images << build(:item_image, item: item)
    end
  end
end
