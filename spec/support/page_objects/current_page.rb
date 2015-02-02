module PageObjects
  class CurrentPage < PageObject
    def accessed_denied_message
      find("div", :text => /not authorised/i)
    end
  end

  def current_page
    CurrentPage.new(self)
  end
end
