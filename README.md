# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
■ URL
IPアドレス：http://18.177.162.161/
Github（最終課題のリポジトリ）：fleamarket_sample_78d

■ Basic認証
ID：admin
Pass：password

■ テスト用アカウント
◯ 購入者用
メールアドレス：buyer123@gmail.com
パスワード：buyer123

◯ 購入用カード情報
番号：4242424242424242
期限：2025/9
セキュリティカード：123

◯ 出品者用
メールアドレス：saler123@gmail.com
パスワード：saler123



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
- has_many :bookmarks, dependent: :destroy
- has_many :bookmark_items, through: :bookmarks, source: :item
- has_one :sending_destination, dependent: :destroy
- has_one :credit_card, dependent: :destroy
- hsa_one :sns_authentication, dependent: destroy

##  addressesテーブル
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
|phone_number|bigint|unique: true|
|user|references|null: false|
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture

##  credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null: false|
|card_id|integer|null: false|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

##  itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduce|text|null: false|
|category_id|references|null: false|
|brand|references||
|condition_id|string|null: false|
|delivery|references|null: false, foreign_key: true|
|prefecture_id|integer|null: false|
|preparation_id|integer|null: false|
|buyer_id|integer||
|seller_id|integer|null: false|
|price|integer|null: false|
### Association
- has_many: images, dependent: :destroy
- has_many: bookmarks, dependent: :destroy
- belongs_to :category
- belongs_to :brand
- belongs_to_active_hash :condition
- belongs_to :delivery
- belongs_to_active_hash :preparation
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User
- belongs_to_active_hash :prefecture

##  imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
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

##  brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many: items

##  conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|condition|string|null: false|
### Association
- has_many: items

##  deliveriesテーブル
|Column|Type|Options|
|------|----|-------|
|method|string|null: false|
|ancestry|string|null: false|
### Association
- has_many: items

##  preparationsテーブル
|Column|Type|Options|
|------|----|-------|
|preparation|string|null: false|
### Association
- has_many: items

##  prefecturesテーブル
|Column|Type|Options|
|------|----|-------|
|prefecture|string|null: false|
### Association
- has_many: items
- has_many: addresses

##  bookmarksテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to: user
- belongs_to: item



* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
