class CreateSendings < ActiveRecord::Migration[6.0]
  def change
    create_table :sendings do |t|
      t.references :user, null: false, foreign_key: true, type: :integer
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.integer :postal_code, null: false
      t.string :city, null: false
      t.string :block, null: false
      t.string :building, null: false
      t.string :roomnumber
      t.string :telephone, unique: true
    end
  end
end
