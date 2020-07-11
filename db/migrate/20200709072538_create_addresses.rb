class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string "destination_last_name",null: false
      t.string "destination_first_name",null: false
      t.string "destination_last_name_kana",null: false
      t.string "destination_first_name_kana",null: false
      t.integer "post_code", null:false
      t.integer "prefecture_id",  null: false
      t.string "city",  null: false
      t.string "address", null: false
      t.string "buliding_name"
      t.bigint "phone_number", unique: true
      t.references :user, null: false
      t.timestamps
    end
  end
end
