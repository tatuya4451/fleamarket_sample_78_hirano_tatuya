class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true, null: false
      t.references :item, null: false, foreign_key: true, null: false

      t.timestamps
      t.index [:user_id, :item_id], unique: true
    end
  end
end
