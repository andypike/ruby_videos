module Videos
  class SuggestionForm < FormObject
    route_as :suggestion

    attribute :title, :string, :default => ""
    attribute :url,   :string, :default => ""

    validates :title,
      :length   => { :maximum => 255 },
      :presence => true

    validates :url,
      :url    => true,
      :length => { :maximum => 255 }
  end
end
