module Videos
  class SuggestionForm < FormObject
    route_as :suggestion

    attribute :title, :string, :default => ""
    attribute :url,   :string, :default => ""
    attribute :user,  User

    validates :title,
      :length   => { :maximum => 255 },
      :presence => true

    validates :url,
      :url    => true,
      :length => { :maximum => 255 }

     validates :user,
      :presence => true
  end
end
