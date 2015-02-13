module PageObjects
  class CurrentPage < PageObject
    def accessed_denied_message
      find("div", :text => /not authorised/i)
    end
  end
end

module PageObjectHelpers
  let(:current_page) { PageObjects::CurrentPage.new(self) }
end
