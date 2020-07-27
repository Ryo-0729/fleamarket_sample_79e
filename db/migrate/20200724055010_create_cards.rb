class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.references :user, null: false
      t.string :token, null: false
    end
  end
end
