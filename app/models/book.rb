class Book < ActiveRecord::Base
  belongs_to :publisher
  has_many :products, dependent: :destroy

  validates_presence_of :publisher_id, :title
end
