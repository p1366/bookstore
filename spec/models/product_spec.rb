RSpec.describe Product, type: :model do
  it { is_expected.to belong_to(:shop) }
  it { is_expected.to belong_to(:book) }

  %i[shop_id book_id copies_in_stock copies_sold].each do |attr|
    it { is_expected.to validate_presence_of(attr) }
  end

  it { is_expected.to validate_numericality_of(:copies_in_stock).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:copies_sold).is_greater_than_or_equal_to(0) }
end
