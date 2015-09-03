require 'shared/book_world_context.rb'

RSpec.describe PgJsonService do
  describe '#json' do
    shared_examples 'empty shops' do
      it 'should return shops key with empty array' do
        expect(json).to match({ 'shops' => [] })
      end
    end

    context 'no products at all' do
      let(:json) do
        JSON.parse(described_class.new(create(:publisher).id).json)
      end

      include_examples 'empty shops'
    end

    context 'no sales at all' do
      let(:json) do
        JSON.parse(described_class.new(create(:product).book.publisher.id).json)
      end

      include_examples 'empty shops'
    end

    context 'no sales for the publisher' do
      let(:json) do
        product = create :product, copies_sold: 1
        book = create :book                             # another publisher created
        create :product, shop: product.shop, book: book # copies_sold: 0 in same shop
        JSON.parse(described_class.new(book.publisher.id).json)
      end

      include_examples 'empty shops'
    end

    context 'it works!' do
      include_context 'book_world'

      let(:json1) { JSON.parse(described_class.new(publisher1.id).json) }
      # let(:json2) { JSON.parse(described_class.new(publisher2.id).json) }

      it 'should return right json' do
        expect(json1).to match(right1)
      end
    end
  end
end
