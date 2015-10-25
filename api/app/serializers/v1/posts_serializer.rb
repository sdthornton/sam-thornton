module V1
  class PostsSerializer < ActiveModel::Serializer

    attributes :title, :url, :category, :created_at, :abstract, :id

    def abstract
      object.body[0..200]
    end

  end
end
