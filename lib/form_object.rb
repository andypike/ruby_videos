class FormObject
  include SimpleFormObject

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
