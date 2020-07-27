class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false
      t.references :item, null: false
      t.text :text, null: false
    end
  end
end
