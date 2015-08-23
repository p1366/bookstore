class Product < ActiveRecord::Base
  belongs_to :shop
  belongs_to :book
end
