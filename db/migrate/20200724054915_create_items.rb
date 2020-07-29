class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true, type: :integer
      t.references :brand, foreign_key: true
      t.references :category, foreign_key: true
      t.string :name
      t.integer :price
      t.text :text
      t.integer :condition_id
      t.integer :postage_payer_id
      t.integer :prefecture_id
      t.integer :preparation_id
      t.datetime :completed_at
    end
  end
end
