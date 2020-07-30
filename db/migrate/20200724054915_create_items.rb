class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true, type: :integer
      t.references :category, foreign_key: true
      t.string :name, null: false
      t.integer :price, null: false
      t.text :text, null: false
      t.integer :brand_id
      t.integer :condition_id, null: false
      t.integer :postage_payer_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :preparation_id, null: false
      t.datetime :completed_at
    end
  end
end
