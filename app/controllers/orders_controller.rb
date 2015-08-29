class OrdersController < ApplicationController
  ORDER_PARAMS = %i[shop_id book_id copies]

  before_action :find_product_and_copies
  attr_reader :product, :copies

  def create
    if product.sell(copies)
      render plain: 'Order created', status: 201
    else
      render plain: 'Wrong copies parameter', status: 406
    end
  end

  private

  def find_product_and_copies
    ORDER_PARAMS.each { |param| params.require(param) }
    prms     = params.permit(ORDER_PARAMS)
    @copies  = prms.delete(:copies).to_i
    # Let AR check shop_id and book_id
    @product = Product.find_by!(prms)
  end
end
