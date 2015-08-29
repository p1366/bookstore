Rails.application.routes.draw do
  scope '/api/v1' do
    # for a specific Publisher it should return the list of shops selling at least one book of that publisher

    # GET /api/v1/publisher_stat?publisher_id=1
    # get '/publisher_stat', to: 'publisher_stats#show'
    # resource :publisher_stat, only: :show

    # GET /api/v1/publishers/1/shops
    # get '/publishers/:id/shops', to: 'publishers#shops'
    resources :publishers, only: [] do
      get 'shops', on: :member
    end

    # for a specific Shop it should mark one or multiple copies of a book as sold.

    # POST /api/v1/order shop_id=1 book_id=1 quantity=1
    # post '/order', to: 'orders#create'
    # resource :order, only: :create

    # POST /api/v1/shops/1/order book_id=1 copies=1
    # post '/shops/:shop_id/order', to: 'orders#create'
    resources :shops, only: [] do
      resource :order, only: :create
    end
  end
end
