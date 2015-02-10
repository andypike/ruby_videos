class AutoMapper
  attr_reader :source

  def initialize(source)
    @source = source
  end

  def map_to(destination)
    destination.tap do |d|
      source.attributes.each do |attribute, value|
        d.public_send("#{attribute}=", value) if d.respond_to?(attribute)
      end
    end
  end
end
