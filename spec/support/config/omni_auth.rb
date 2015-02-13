OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.before(:each) do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      :provider => "github",
      :uid      => "12345",
      :info => {
        :nickname => "andypike",
        :name     => "Andy Pike",
        :image    => "https://avatars.githubusercontent.com/u/117697?v=3"
      }
    )
  end
end
