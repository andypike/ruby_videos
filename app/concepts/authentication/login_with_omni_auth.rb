module Authentication
  class LoginWithOmniAuth
    include Wisper::Publisher

    attr_reader :info

    def initialize(info)
      @info = info
    end

    def call
      if info.valid?
        user = find_or_create_user
        publish(:success, user)
      else
        publish(:fail)
      end
    end

    private

    def find_or_create_user
      uid_and_provider = { :uid => info.uid, :provider => info.provider }

      User.find_or_create_by(uid_and_provider) do |u|
        u.name      = info.name
        u.nickname  = info.nickname
        u.image_url = info.image_url
      end
    end
  end
end
