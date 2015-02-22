module Videos
  class CreateSuggestion
    include Wisper::Publisher

    attr_reader :form

    def initialize(form)
      @form = form
    end

    def call
      if form.valid?
        suggestion = Video.new
        AutoMapper.new(form).map_to(suggestion).tap do |m|
          m.save
          # send notification

          publish(:ok, m)
        end
      else
        publish(:fail)
      end
    end
  end
end
