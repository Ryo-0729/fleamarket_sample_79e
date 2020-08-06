class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true, type: :integer
      t.string :name, null: false
      t.text :text, null: false
      t.references :category, foreign_key: true, null: false
      t.integer :size_id
      t.string :brand
      t.integer :condition_id, null: false
      t.integer :postage_payer_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :shipping_method_id, null: false
      t.integer :preparation_id, null: false
      t.integer :price, null: false
      t.timestamps
      t.integer :buyer_id
      t.integer :seller_id
    end
  end
end
