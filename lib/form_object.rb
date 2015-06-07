class FormObject
  include SimpleFormObject

  attribute :id, :integer

  def self.build_from(key, params, additional_params = {})
    attributes = params.fetch(key, {}).merge(additional_params)

    new(attributes).tap do |f|
      f.id = params[:id]
    end
  end

  def persisted?
    id.present? && id.to_i > 0
  end
end
