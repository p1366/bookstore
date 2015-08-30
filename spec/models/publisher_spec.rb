RSpec.describe Publisher, type: :model do
  it { is_expected.to have_many(:books).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name) }
end
