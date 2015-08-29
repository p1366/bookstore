class Product < ActiveRecord::Base
  belongs_to :shop
  belongs_to :book

  validates_presence_of :shop_id, :book_id, :copies_in_stock, :copies_sold
  validates :copies_in_stock, :copies_sold, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
