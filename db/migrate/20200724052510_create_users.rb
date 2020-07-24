class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :last_namem, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :birth_year, null: false
      t.string :birth_month, null: false
      t.string :birth_day, null: false
      t.string :email, null: false, unique: true
      t.string :password, null: false
    end
  end
end
