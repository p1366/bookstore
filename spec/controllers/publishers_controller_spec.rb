RSpec.describe PublishersController, type: :controller do
  describe 'GET shops' do
    COPIES = 5
    let(:product) { create :product, copies_in_stock: COPIES }

    context 'positive' do
      it "should return valid JSON with status 200" do
        get :shops, id: product.book.publisher.id
        
        expect(response.status).to eq(200)
        expect { JSON.parse(response.body) }.not_to raise_error
      end
    end

    context 'negative' do
      shared_examples 'get with wrong publisher id:' do |publisher_id|
        it 'should return 404 when shop_id and/or book_id are wrong' do
          get :shops, id: publisher_id
          expect(response.status).to eq(404)
        end
      end

      include_examples 'get with wrong publisher id:', 0
      include_examples 'get with wrong publisher id:', -1
      include_examples 'get with wrong publisher id:', 111
    end
  end
end
