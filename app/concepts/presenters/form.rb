module Presenters
  class Form
    include SimpleFormObject

    route_as :presenter

    attribute :name,    :string, :default => ""
    attribute :twitter, :string, :default => ""
    attribute :github,  :string, :default => ""
    attribute :website, :string, :default => ""
    attribute :title,   :string, :default => ""
    attribute :bio,     :text,   :default => ""
    attribute :photo,   :file,   :default => ""

    validates :name,
      :length   => { :maximum => 255 },
      :presence => true
  end
end
