module PageObjects
  class SuggestionPage < PageObjectWithForm
    def element_prefix
      :suggestion
    end

    def defaults
      @defaults ||= {
        :title => "All the little things",
        :url   => Faker::Internet.url
      }
    end
  end
end

module PageObjectHelpers
  let(:suggestion_page) { PageObjects::SuggestionPage.new(self) }
end
