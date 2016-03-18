module V1
  class PostSerializer < ActiveModel::Serializer

    attributes :title, :url, :category, :body, :tag_list, :created_at, :id

  end
end
