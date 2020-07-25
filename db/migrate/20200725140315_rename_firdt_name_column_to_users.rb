class RenameFirdtNameColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :firdt_name, :first_name
  end
end
