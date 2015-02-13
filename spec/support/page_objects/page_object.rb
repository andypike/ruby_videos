# Inspired by http://adam.pohorecki.pl/slides/page-objects/#36.0
module PageObjects
  class PageObject
    attr_reader :context

    def initialize(context)
      @context = context
    end

    def find(selector, options = {})
      context.find(selector, options)
    rescue
      MissingElement.new(:element, selector, options)
    end

    def find_link(label)
      context.find_link(label)
    rescue
      MissingElement.new(:link, label)
    end

    def respond_to_missing?(name, _)
      context.respond_to?(name)
    end

    def method_missing(name, *args, &block)
      context.public_send(name, *args, &block)
    end
  end
end
