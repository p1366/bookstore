RSpec.shared_context 'book_world' do
  let(:publisher1) { create :publisher }
  let(:publisher2) { create :publisher }
  
  let(:book1) { create :book, publisher: publisher1 }
  let(:book2) { create :book, publisher: publisher1 }
  let(:book3) { create :book, publisher: publisher2 }
  let(:book4) { create :book, publisher: publisher2 }

  let(:shop1) { create :shop }
  let(:shop2) { create :shop }
  let(:shop3) { create :shop }

  let(:book_world) { [
    #   publisher1      publisher2
    # book1   book2   book3   book4
    [ [1, 3], [2, 4], [1, 0], [2, 0] ], # shop1
    [ [3, 0], [4, 0], [3, 1], [4, 2] ], # shop2
    [ [5, 1], [6, 2], [5, 4], [6, 0] ], # shop3
    # [copies_in_stock, copies_sold]
  ] }

  before(:each) do
    shops = [shop1, shop2, shop3]
    books = [book1, book2, book3, book4]
    book_world.each_with_index do |row, shop_i|
      shop = shops[shop_i]
      row.each_with_index do |product, book_i|
        book = books[book_i]
        create :product, shop: shop, book: book, copies_in_stock: product.first, copies_sold: product.last
      end
    end
  end

  let(:right1) { {
    'shops' => [
      {
        'id'               => shop3.id,
        'name'             => shop3.name,
        'books_sold_count' => 3,
        'books_in_stock'   => [
          {
            'id'              => book1.id,
            'title'           => book1.title,
            'copies_in_stock' => 5
          },
          {
            'id'              => book2.id,
            'title'           => book2.title,
            'copies_in_stock' => 6
          }
        ]
      },
      {
        'id'               => shop1.id,
        'name'             => shop1.name,
        'books_sold_count' => 7,
        'books_in_stock'   => [
          {
            'id'              => book1.id,
            'title'           => book1.title,
            'copies_in_stock' => 1
          },
          {
            'id'              => book2.id,
            'title'           => book2.title,
            'copies_in_stock' => 2
          }
        ]
      }
    ]
  } }

  # let(:right2) { no no no David Blaine }
end
