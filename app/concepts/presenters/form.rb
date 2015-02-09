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

    # TODO: Refactor out this boilerplate
    def self.build_from(key, params)
      new(params[key]).tap do |f|
        f.id = params[:id]
      end
    end

    attribute :id, :integer
    def persisted?
      id.present? && id.to_i > 0
    end
  end
end
