class FormObject
  include SimpleFormObject

  attribute :id, :integer

  def self.build_from(key, params)
    new(params[key]).tap do |f|
      f.id = params[:id]
    end
  end

  def persisted?
    id.present? && id.to_i > 0
  end
end
