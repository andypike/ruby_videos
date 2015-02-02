module Presenters
  class Form
    include SimpleFormObject

    route_as :presenter

    attribute :name, :string

    validates :name,
      :length   => { :maximum => 255 },
      :presence => true
  end
end
