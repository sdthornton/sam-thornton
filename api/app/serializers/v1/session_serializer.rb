module V1
  class SessionSerializer < ActiveModel::Serializer

    attributes :email, :token_type, :admin_id, :access_token

    def admin_id
      object.id
    end

    def token_type
      'Bearer'
    end

  end
end
