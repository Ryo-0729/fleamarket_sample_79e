class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.text :text, null: false
      t.integer :condition, null: false
      t.datetime :completed_at
    end
  end
end
