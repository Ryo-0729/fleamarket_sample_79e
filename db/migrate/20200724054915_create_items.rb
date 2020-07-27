class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user
      t.references :brand
      t.references :category
      t.string :name, null: false
      t.integer :price, null:false
      t.text :text, null: false
      t.integer :condition, null: false
      t.datetime :completed_at
    end
  end
end
