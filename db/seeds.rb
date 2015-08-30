# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

publisher1 = Publisher.create(name: 'First Publisher')
publisher2 = Publisher.create(name: 'Last  Publisher')

book1 = Book.create(title: 'Book 11', publisher: publisher1)
book2 = Book.create(title: 'Book 12', publisher: publisher1)
book3 = Book.create(title: 'Book 21', publisher: publisher2)
book4 = Book.create(title: 'Book 22', publisher: publisher2)

shop1 = Shop.create(name: '1st Shop')
shop2 = Shop.create(name: '2st Shop')
shop3 = Shop.create(name: '3st Shop')

book_world = [
  #   publisher1      publisher2
  # book1   book2   book3   book4
  [ [1, 3], [2, 4], [1, 0], [2, 0] ], # shop1
  [ [3, 0], [4, 0], [3, 1], [4, 2] ], # shop2
  [ [5, 1], [6, 2], [5, 4], [6, 0] ], # shop3
  # [copies_in_stock, copies_sold]
]

shops = [shop1, shop2, shop3]
books = [book1, book2, book3, book4]
book_world.each_with_index do |row, shop_i|
  shop = shops[shop_i]
  row.each_with_index do |product, book_i|
    book = books[book_i]
    Product.create(shop: shop, book: book, copies_in_stock: product.first, copies_sold: product.last)
  end
end
