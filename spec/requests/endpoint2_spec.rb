RSpec.describe 'Endpoint 2', type: :request do
  context 'it works!' do
    let(:product) { create :product, copies_in_stock: COPIES }

    shared_examples 'sell copies:' do |copies|
      it "should sell #{copies} from #{COPIES} copies" do
        expect {
          post "/api/v1/shops/#{product.shop_id}/order", { book_id: product.book_id, copies: copies }
          expect(response.status).to eq(201)
          product.reload # need for request specs
        }.to change{ [product.copies_in_stock, product.copies_sold] }.
          from( [product.copies_in_stock,          product.copies_sold         ] ).
          to(   [product.copies_in_stock - copies, product.copies_sold + copies] )
      end
    end

    include_examples 'sell copies:', 1
    include_examples 'sell copies:', 2
    include_examples 'sell copies:', COPIES - 1
    include_examples 'sell copies:', COPIES
  end
end
