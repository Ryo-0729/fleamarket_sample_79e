FactoryBot.define do
  factory :user do
    nickname                 {"taro"}
    email                    {"taro@gmail.com"}
    password                 {"password"}
    password_confirmation    {"password"}
    last_name                {"田中"}
    first_name               {"太郎"}
    last_name_kana           {"タナカ"}
    first_name_kana          {"タロウ"}
    birthyear                {1990}
    birthmonth               {8}
    birthday                 {01}
    post_first_name          {"田中"}
    post_last_name           {"太郎"}
    post_first_name_kana     {"タナカ"}
    post_last_name_kana      {"タロウ"}
    post_cord                {9999999}
    prefecture_id            {"大阪府"}
    city                     {"大阪市中央区"}
    address                  {"難波5-1-60"}
    building                 {"なんばスカイオ15F"}
    telephone                {99999999999}
  end
end

