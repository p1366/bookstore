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

Product.create(shop: shop1, book: book1, copies_in_stock: 1, copies_sold: 1)
Product.create(shop: shop1, book: book2, copies_in_stock: 2, copies_sold: 2)
Product.create(shop: shop2, book: book1, copies_in_stock: 3, copies_sold: 0)
Product.create(shop: shop2, book: book2, copies_in_stock: 4, copies_sold: 0)
Product.create(shop: shop3, book: book1, copies_in_stock: 5, copies_sold: 3)
Product.create(shop: shop3, book: book2, copies_in_stock: 6, copies_sold: 4)

Product.create(shop: shop1, book: book3, copies_in_stock: 1, copies_sold: 0)
Product.create(shop: shop1, book: book4, copies_in_stock: 2, copies_sold: 0)
Product.create(shop: shop2, book: book3, copies_in_stock: 3, copies_sold: 1)
Product.create(shop: shop2, book: book4, copies_in_stock: 4, copies_sold: 2)
Product.create(shop: shop3, book: book3, copies_in_stock: 5, copies_sold: 4)
Product.create(shop: shop3, book: book4, copies_in_stock: 6, copies_sold: 0)
