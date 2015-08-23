class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :shop, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.integer :copies_in_stock, null: false
      t.integer :copies_sold, default: 0, null: false

      t.timestamps null: false
    end
  end
end
