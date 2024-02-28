class CreateCheckouts < ActiveRecord::Migration[7.1]
  def change
    create_table :checkouts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.date :transaction_date
      t.float :price

      t.timestamps
    end
  end
end
