module Authentication
  class OmniAuthInfo
    include SimpleFormObject

    attribute :provider,  :string
    attribute :uid,       :string
    attribute :nickname,  :string
    attribute :name,      :string
    attribute :image_url, :string

    validates :provider,
      :uid,
      :nickname,
      :name,
      :image_url,
      :presence => true

    def initialize(omni_auth_hash = {})
      fail "nil OmniAuth hash passed to OmniAuthInfo#new" if omni_auth_hash.nil?

      @provider  = omni_auth_hash.fetch(:provider) { "" }
      @uid       = omni_auth_hash.fetch(:uid)      { "" }

      info_hash  = omni_auth_hash.fetch(:info) { {} }
      @nickname  = info_hash.fetch(:nickname)  { "" }
      @name      = info_hash.fetch(:name)      { "" }
      @image_url = info_hash.fetch(:image)     { "" }
    end
  end
end
