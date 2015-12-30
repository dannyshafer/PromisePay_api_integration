class CreateMonthlyBills < ActiveRecord::Migration
  def change
    create_table :monthly_bills do |t|
      t.string :name
      t.string :payment_type
      t.string :amount
      t.string :buyer_id
      t.string :seller_id
      t.string :payment_account
      t.string :description

      t.timestamps null: false
    end
  end
end
