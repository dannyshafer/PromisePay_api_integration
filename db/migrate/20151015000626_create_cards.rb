class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :full_name
      t.string :number
      t.string :expiry_month
      t.string :expiry_year
      t.string :cvv

      t.timestamps null: false
    end
  end
end
