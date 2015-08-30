RSpec.describe Shop, type: :model do
  it { is_expected.to have_many(:products).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name) }
end
