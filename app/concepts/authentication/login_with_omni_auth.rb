module Authentication
  class LoginWithOmniAuth
    include Nala::Publisher

    attr_reader :info, :warden

    def initialize(info, warden)
      @info = info
      @warden = warden
    end

    def call
      if info.valid?
        user = find_or_create_user
        warden.login(user)

        publish(:ok, user)
      else
        publish(:fail)
      end
    end

    private

    def find_or_create_user
      uid_and_provider = { :uid => info.uid, :provider => info.provider }

      User.find_or_create_by(uid_and_provider) do |user|
        AutoMapper.new(info).map_to(user)
      end
    end
  end
end
