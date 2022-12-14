## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name_kana    | string | null: false               |
| encrypted_password | string | null: false               |
| email              | string | null: false, unique: true |
| birthday           | date   | null: false               |

## Association
- has_many :items
- has_many :buys


## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| name            | string     | null: false                    |
| price           | integer    | null: false                    |
| status_id       | integer    | null: false                    |
| category_id     | integer    | null: false                    |
| prefecture_id   | integer    | null: false                    |
| days_to_ship_id | integer    | null: false                    |
| delivery_fee_id | integer    | null: false                    |
| text            | text       | null: false                    |


### Association 
- belongs_to :user
- has_one :buy


## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| telephone     | string     | null: false                    |
| building      | string     |                                |
| prefecture_id | integer    | null: false                    |
| buy           | references | null: false, foreign_key: true |


### Association
- belongs_to :buy


## buys テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
  - belongs_to :user
  - belongs_to :item
  - has_one :address