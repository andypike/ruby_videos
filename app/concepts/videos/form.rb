module Videos
  class Form < FormObject
    route_as :video

    attribute :title,        :string, :default => ""
    attribute :description,  :text,   :default => ""
    attribute :presenter_id, :integer
    attribute :url,          :string, :default => ""
    attribute :embed_code,   :text,   :default => ""
    attribute :status,       :string, :default => "draft"
    attribute :cover,        :file,   :default => ""

    validates :title,
      :length   => { :maximum => 255 },
      :presence => true
  end
end
