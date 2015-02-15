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

    validates :description, :embed_code, :cover,
      :presence => true

    validates :status,
      :inclusion => { :in => Video.statuses.keys },
      :presence => true

    validates :url,
      :url => true

    validates :presenter_id,
      :presence => true,
      :numericality => true

    validate :ensure_presenter_id_exists

    private

    def ensure_presenter_id_exists
      return if Presenter.exists?(presenter_id)

      errors.add(:presenter_id, I18n.t(:not_found))
    end
  end
end
