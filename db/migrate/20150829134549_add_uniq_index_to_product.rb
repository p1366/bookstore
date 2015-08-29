class AddUniqIndexToProduct < ActiveRecord::Migration
  def change
    add_index :products, [:shop_id, :book_id], unique: true
  end
end
