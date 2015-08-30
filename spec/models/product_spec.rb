RSpec.describe Product, type: :model do
  it { is_expected.to belong_to(:shop) }
  it { is_expected.to belong_to(:book) }

  %i[shop_id book_id copies_in_stock copies_sold].each do |attr|
    it { is_expected.to validate_presence_of(attr) }
  end

  it { is_expected.to validate_numericality_of(:copies_in_stock).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:copies_sold).is_greater_than_or_equal_to(0) }

  describe '#sell' do
    context 'naive' do
      # see copies_in_stock.rb
      let(:product) { create :product, copies_in_stock: COPIES }

      context 'positive' do
        shared_examples 'sell copies:' do |copies|
          it "should sell #{copies} from #{COPIES} copies" do
            expect {
              expect(product.sell(copies)).to be_truthy
              # product.reload # depends from .sell implementation
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

      context 'negative' do
        shared_examples 'dont sell copies:' do |copies|
          it "should not sell #{copies} from #{COPIES} copies" do
            expect {
              expect(product.sell(copies)).to be_falsey
              # product.reload # depends from .sell implementation
            }.to_not change{ [product.copies_in_stock, product.copies_sold] }
          end
        end

        include_examples 'dont sell copies:', 0
        include_examples 'dont sell copies:', -1
        include_examples 'dont sell copies:', -COPIES

        it 'should not sell with copies > copies_in_stock' do
          shadow = Product.find(product.id)
          allowed_q = product.copies_in_stock
          shadow.update_attributes(copies_in_stock: allowed_q - 1)

          expect(product.sell(allowed_q)).to be_falsey

          # product.reload # depends from .sell implementation
          expect(product.copies_in_stock).to eq(shadow.copies_in_stock)
          expect(product.copies_sold).to eq(shadow.copies_sold)
        end
      end
    end
  end
end
