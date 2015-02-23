module Videos
  class CreateSuggestion
    include Wisper::Publisher

    attr_reader :form

    def initialize(form)
      @form = form
    end

    def call
      if form.valid?
        suggestion = Video.new(:suggestion => true)

        AutoMapper.new(form).map_to(suggestion).tap do |s|
          s.save

          VideoMailer.suggestion(s).deliver_later

          publish(:ok, s)
        end
      else
        publish(:fail)
      end
    end
  end
end
