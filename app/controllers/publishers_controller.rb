class PublishersController < ApplicationController
  def shops
    render json: PgJsonService.new(publisher.id).json
  end

  private

  def publisher
    # Let AR check Publisher id
    Publisher.find(params[:id])
  end
end
