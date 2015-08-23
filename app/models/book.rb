class Book < ActiveRecord::Base
  belongs_to :publisher
  has_many :products, dependent: :destroy
end
