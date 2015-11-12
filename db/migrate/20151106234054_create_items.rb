class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :payment_type
      t.string :amount
      t.string :buyer_id
      t.string :seller_id
      t.string :description

      t.timestamps null: false
    end
  end
end
