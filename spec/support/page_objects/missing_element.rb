module PageObjects
  class MissingElement
    attr_reader :category, :selector, :options

    def initialize(category, selector, options = {})
      @category = category
      @selector = selector
      @options  = options
    end

    def present?
      false
    end

    def respond_to_missing?(_, _)
      true
    end

    def method_missing(name, *_args, &_block)
      fail %(
        Unable to call `##{name}` because the #{category} `#{selector}`
        with options #{options.inspect} couldn't be found
      )
    end
  end
end
