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
- has_many :items, dependent: destroy'
- has_many :sendings, dependent: destroy'
- has_many :cards, dependent: destroy'
- has_many :comments

## sendingsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|last_name|string|null: false|
|first_name|string|null:false|
|last_name_kana|string|null:false|
|first_name_kana|string|null:false|
|postal_code|integer|null:false|
|prefecture_id(acitve_hash)|integer|null: false|
|city|string|null:false|
|block|string|null:false|
|building|string|null:false|
|roomnumber|string|--------|
|telephone|string|unique:true|

### Association
- belongs_to :user'


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
|size_id(acitve_hash)|integer|null: false|
|postage_payer_id(acitve_hash)|integer|null: false|
|prefecture_id(acitve_hash)|integer|null: false|
|preparation_id(acitve_hash)|integer|null: false|
|completed_at|datetime|-------|


### Association
- belongs_to :user'
- belongs_to :category'
- belongs_to :brand'
- belongs_to :item'
- belongs_to :comment'


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

### Association
- has_many :items'


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null:false|

### Association
- has_many :items'


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|token|string|null:false|

### Association
- belongs_to :items'


## petsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|item_id|references|null:false, foreign_key:true|

### Association
- belongs_to :user'

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false, foreign_key:true|
|item_id|references|null:false, foreign_key:true|
|text|text|null:false|

### Association
- belongs_to :user'
- belongs_to :item'

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|item_id|references|null:false, foreign_key:true|

### Association
- belongs_to :item'