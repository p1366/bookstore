class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :copies_in_stock

  def id
    object.book.id
  end

  def title
    object.book.title
  end
end
