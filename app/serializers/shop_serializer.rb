class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :books_sold_count
  has_many :products, root: :books_in_stock
end
