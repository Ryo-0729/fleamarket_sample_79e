## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string¥null:|null:false|
|last_name|string|null:false|
|first_name|string|null:false|
|last_name_kana|string|null:false|
|first_name_kana|string|null:false|
|birth_year|string|null:false|
|birth_month|string|null:false|
|birth_day|string|null:false|
|email|string|null:false, unique: true|
|password|string|null:false|


### Association
- has_many :items, dependent: destroy
- belongs_to :sending, dependent: destroy
- belongs_to :card, dependent: destroy


## sendingsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|last_name|string|null: false|
|first_name|string|null:false|
|last_name_kana|string|null:false|
|first_name_kana|string|null:false|
|postal_code|integer|null:false|
|prefecture|string|null:false|
|city|string|null:false|
|adress1|string|null:false|
|adress2|string|null:false|
|adress3|string|null:false|
|telephone|string|unique:true|

### Association
- belongs_to :user


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|brand_id|references|null:false, foreign_key:true|
|category_id|references|null:false, foreign_key:true|
|name|string|null:false|
|text|text|null:false|
|condition|integer|null:false|
|price|integer|null:false|
|brand|references|null: false, foreign_key:true|
|size|references|null: false, foreign_key:true|
|category|references|null: false, foreign_key:true|
|postage_payer|references|null: false, foreign_key:true|
|prefecture|references|null:false, foreign_key:true|
|preparation_day|references|null: false, foreign_key:true|
|item_img|references|null: false, foreign_key:true|
|completed_at|datetime|-------|


### Association
- belongs_to :user, dependent: destroy
- belongs_to :category, , dependent: destroy
- belongs_to :brand, , dependent: destroy


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|references|null:false|

### Association
- has_many :items


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null:false|

### Association
- has_many :items


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|item_id|references|null:false, foreign_key:true|
|money|integer|null:false|

### Association
- has_many :items


## petsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|item_id|references|null:false, foreign_key:true|

### Association
- belongs_to :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|item_id|references|null:false, foreign_key:true|
|text|text|null:false|

### Association
- belongs_to :user
- belongs_to :item

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|item_id|references|null:false, foreign_key:true|

### Association
- belongs_to :item