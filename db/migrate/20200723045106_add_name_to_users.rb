class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, :lastname, :firstname, :lastname_kana, :firstname_kana, :dirth_year, :birth_manth, :birth_day, :send_lastname, :send_firstname, :send_lastname_kana, :send_firstname_kana, :post_num, :prefectures, :city, :address, :address_2nd,
  end
end
