class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address_line1
      t.string :state
      t.string :city
      t.string :zip
      t.string :country
      t.string :dob

      t.timestamps null: false
    end
  end
end
