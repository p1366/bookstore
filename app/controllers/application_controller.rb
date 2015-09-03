class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render nothing: true, status: 404
  end
end
