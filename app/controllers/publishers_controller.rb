class PublishersController < ApplicationController
  def shops
    render json: ArPreloadService.new(publisher.id).shops, root: 'shops'
  end

  private

  def publisher
    # Let AR check Publisher id
    Publisher.find(params[:id])
  end
end
