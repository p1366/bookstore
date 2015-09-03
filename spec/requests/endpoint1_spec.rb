require 'shared/book_world_context.rb'

RSpec.describe 'Endpoint 1', type: :request do
  context 'it works!' do
    include_context 'book_world'

    let(:result1) do
      get "/api/v1/publishers/#{publisher1.id}/shops"
      JSON.parse(response.body)
    end

    it 'should return right json' do
      expect(result1).to match(right1)
    end
  end
end
