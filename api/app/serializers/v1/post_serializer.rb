module V1
  class PostSerializer < ActiveModel::Serializer

    attributes :title, :url, :category, :body, :created_at, :id

  end
end
