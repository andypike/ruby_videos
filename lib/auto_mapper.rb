class AutoMapper
  attr_reader :source

  def initialize(source)
    @source = source
  end

  def map_to(destination)
    destination.tap do |d|
      source.attributes.each do |attribute, _|
        if d.respond_to?(attribute)
          value = source.public_send(attribute)
          d.public_send("#{attribute}=", value)
        end
      end
    end
  end
end
