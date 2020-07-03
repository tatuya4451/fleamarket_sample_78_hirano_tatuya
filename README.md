# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

##  usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
### Association
- has_many :seller_items, foreign_key: "seller_id", class_name: "items"
- has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
- has_one :profile, dependent: :destroy
- has_one :sending_destination, dependent: :destroy
- has_one :credit_card, dependent: :destroy

##  profilesテーブル
|Column|Type|Options|
|------|----|-------|
|avatar|string||
|introduction|text||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

##  sending_destinationsテーブル
|Column|Type|Options|
|------|----|-------|
|destination_last_name|string|null: false|
|destination_first_name|string|null: false|
|destination_last_name_kana|string|null: false|
|destination_first_name_kana|string|null: false|
|post_code|integer(7)|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|building_name|string||
|phone_number|integer|unique: true|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- Gemのjp_prefecture か active_hash にて都道府県取得

##  credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false, unique: true|
|expirations_month|integer|null: false|
|expirations_year|integer|null: false|
|security_code|integer|null: false|
|user|references|null: false|
### Association
- belongs_to :user

##  itemsテーブル
|Column|Type|Options|
|------|----|-------|
|item_image|references|null: false|
|name|string|null: false|
|introduce|text|null: false|
|category|references|null: false|
|size|references|null: false|
|brand|references||
|item_condition|references|null: false|
|postage_payer|references|null: false|
|delivery_method|references|null: false|
|preparation_days|references|null: false|
|buyer|references||
|seller|references|null: false|
|price|integer|null: false|
|trading_status|string|null: false|
|deal_closed_date|timestamp||
### Association
- has_many: item_images, dependent: :destroy
- belongs_to_active_hash :category
- belongs_to_active_hash :size
- belongs_to :brand
- belongs_to_active_hash :item_condition
- belongs_to_active_hash :postage_payer
- belongs_to_active_hash :delivery_method
- belongs_to_active_hash :preparation_day
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User
- Gemのjp_prefecture か active_hash にて都道府県取得

##  item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false|
|url|string|null: false|
### Association
- belongs_to :item

##  categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many: items

##  sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|string|null: false|
### Association
- has_many: items

##  brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many: items

##  item_conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|item_condition|string|null: false|
### Association
- has_many: items

##  postage_payersテーブル
|Column|Type|Options|
|------|----|-------|
|postage_payer|string|null: false|
### Association
- has_many: items

##  delivery_methodsテーブル
|Column|Type|Options|
|------|----|-------|
|delivery_method|string|null: false|
### Association
- has_many: items

##  preparation_daysテーブル
|Column|Type|Options|
|------|----|-------|
|preparation_days|string|null: false|
### Association
- has_many: items

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
