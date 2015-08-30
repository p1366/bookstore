RSpec.describe Book, type: :model do
  it { is_expected.to belong_to(:publisher) }
  it { is_expected.to have_many(:products).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:publisher_id) }
  it { is_expected.to validate_presence_of(:title) }
end
