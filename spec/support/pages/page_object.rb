# Inspired by http://adam.pohorecki.pl/slides/page-objects/#36.0
module PageObjects
  class PageObject
    attr_reader :context

    def initialize(context)
      @context = context
    end

    def find(selector, options)
      context.find(selector, options)
    rescue
      nil
    end

    def find_link(label)
      context.find_link(label)
    rescue
      nil
    end

    def respond_to_missing?(name, _)
      context.respond_to?(name)
    end

    def method_missing(name, *args, &block)
      context.__send__(name, *args, &block)
    end
  end
end
