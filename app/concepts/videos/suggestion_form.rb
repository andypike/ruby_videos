module Videos
  class SuggestionForm < FormObject
    route_as :suggestion

    attribute :title, :string, :default => ""
    attribute :url,   :string, :default => ""
  end
end
