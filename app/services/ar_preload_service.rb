class ArPreloadService # AKA ArPreloadSux
  attr_reader :publisher_id

  def initialize(publisher_id)
    @publisher_id = publisher_id.to_i
  end

  def shops
    Shop.
      select(
        :id,
        :name,
        'sum(products.copies_sold) as books_sold_count').
      joins(products: :book).
      where(books: { publisher_id: publisher_id}).
      group(:id).
      order('books_sold_count').
      having('sum(products.copies_sold) > 0').
    to_a.tap do |ss|
      preloader = ActiveRecord::Associations::Preloader.new # <-facepalm
      preloader.preload(ss, :products,
        Struct.new(:values, :bind_values).new({ where: "book_id IN (SELECT id FROM books where publisher_id = #{publisher_id})" }, []))
      products = ss.flat_map(&:products)
      preloader.preload(products, :book)
    end
  end
end
