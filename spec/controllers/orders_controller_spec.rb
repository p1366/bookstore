RSpec.describe OrdersController, type: :controller do
  describe 'POST create' do
    # see copies_in_stock.rb
    let(:product) { create :product, copies_in_stock: COPIES }

    shared_examples 'sell copies and get status:' do |copies, status|
      it "should return #{status} when trying to sell #{copies} from #{COPIES} copies" do
        post :create, shop_id: product.shop_id, book_id: product.book_id, copies: copies
        expect(response.status).to eq(status)
      end
    end

    context 'positive' do
      include_examples 'sell copies and get status:', 1,          201
      include_examples 'sell copies and get status:', 2,          201
      include_examples 'sell copies and get status:', COPIES - 1, 201
      include_examples 'sell copies and get status:', COPIES,     201
    end

    context 'negative' do
      shared_examples 'sell with wrong shop_id, book_id:' do |shop_id, book_id|
        it 'should return 404 when shop_id and/or book_id are wrong' do
          shop_id = product.shop_id if shop_id == 1
          book_id = product.book_id if book_id == 1

          post :create, shop_id: shop_id, book_id: book_id, copies: 1
          expect(response.status).to eq(404)
        end
      end

      include_examples 'sell with wrong shop_id, book_id:', 0, 0
      include_examples 'sell with wrong shop_id, book_id:', 0, 1
      include_examples 'sell with wrong shop_id, book_id:', 1, 0
      include_examples 'sell with wrong shop_id, book_id:', -1, 1
      include_examples 'sell with wrong shop_id, book_id:', 1, -1
      include_examples 'sell with wrong shop_id, book_id:', 1, 111
      include_examples 'sell with wrong shop_id, book_id:', 111, 1

      include_examples 'sell copies and get status:', 0,       406
      include_examples 'sell copies and get status:', -1,      406
      include_examples 'sell copies and get status:', -COPIES, 406
    end
  end
end
