class PgJsonService
  attr_reader :publisher_id

  def initialize(publisher_id)
    @publisher_id = publisher_id.to_i
  end

  def json
    ActiveRecord::Base.connection.select_value(json_query)
  end

  private

  def json_query
<<-SQL
SELECT row_to_json(root_row)
FROM
(
  SELECT
  (
    SELECT COALESCE(array_to_json(array_agg(row_to_json(shop_row))), '[]')
    FROM
    (
      SELECT
        shops.id AS id,
        shops.name AS name,
        SUM(products.copies_sold) AS books_sold_count,
        (
          SELECT array_to_json(array_agg(row_to_json(book_row)))
          FROM
          (
            SELECT
              books.id AS id,
              books.title AS title,
              products.copies_in_stock AS copies_in_stock
            FROM products
            INNER JOIN books ON books.id = products.book_id AND books.publisher_id = #{ publisher_id }
            WHERE products.shop_id = shops.id
          ) book_row
        ) AS books_in_stock
      FROM shops
      INNER JOIN products ON products.shop_id = shops.id
      INNER JOIN books    ON books.id = products.book_id AND books.publisher_id = #{ publisher_id }
      GROUP BY shops.id
      HAVING SUM(products.copies_sold) > 0
      ORDER BY books_sold_count
    ) AS shop_row
  ) AS shops
) AS root_row
SQL
  end
end
