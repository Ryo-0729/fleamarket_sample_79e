class PostToPet < ActiveRecord::Migration[6.0]
  def change
    rename_table :posts, :pets
  end
end
