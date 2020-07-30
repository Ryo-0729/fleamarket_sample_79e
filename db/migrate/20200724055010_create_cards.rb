class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.references :user, null: false, foreign_key: true, type: :integer
      t.string :token, null: false
      t.string :customer_id, null: false
      t.string :card_id, null: false
    end
  end
end
