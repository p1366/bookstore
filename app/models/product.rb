class Product < ActiveRecord::Base
  belongs_to :shop
  belongs_to :book

  validates_presence_of :shop_id, :book_id, :copies_in_stock, :copies_sold
  validates :copies_in_stock, :copies_sold, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def sell(quantity)
    quantity > 0 ? do_sell(quantity) : false
  end

  private

  def do_sell(quantity)
    transaction do
      lock!
      unless quantity > copies_in_stock
        self.copies_in_stock -= quantity
        self.copies_sold     += quantity
        save!
      end
    end
  end
end
