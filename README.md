## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birth_year         | string | null: false |
| birth_month        | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| introduction       | text   | null: false |


### Association
  
- has_many :items
- belongs :buys
- belongs :address

## items テーブル

| Column       | Type      | Options                        |
| ------------ | --------- | ------------------------------ |
| name         | string    | null: false                    |
| price        | integer   | null: false                    |
| status       | integer   | null: false                    |
| user_id      | integer   | null: false, foreign_key: true |
| condition    | integer   | null: false                    |
| trade_status | integer   | null: false                    |
| category_id  | reference | null: false                    |
| text         | text      | null: false                    |



### Association
  
- belong_to :users
- belong_to :addresses
- belong_to :buys

## addresses テーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| user_id          | reference | null: false |
| family_name      | string    | null: false |
| first_name       | string    | null: false |
| family_name_kana | string    | null: false |
| first_name_kana  | string    | null: false |
| post_card        | string    | null: false |
| city             | string    | null: false |
| address          | string    | null: false |
| telephone        | string    | null: false |
| building         | string    | null: false |
| prefacture       | string    | null: false |


### Association
  
- belong_to :users


## buys テーブル

| Column      | Type      | Options                        |
| ----------- | --------- | ------------------------------ |
| user_id     | reference | null: false, foreign_key: true |
| bought_item | string    | null: false                    |


### Association
  
- has_many :prototypes
- has_many :comments