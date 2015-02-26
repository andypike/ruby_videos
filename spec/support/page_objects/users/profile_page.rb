module PageObjects
  class ProfilePage < PageObjectWithForm
    def open
      visit path
    end

    def path
      edit_profile_path
    end

    def element_prefix
      :user
    end

    def defaults
      @defaults ||= {
        :opted_into_newsletters => false
      }
    end
  end
end

module PageObjectHelpers
  let(:profile_page) { PageObjects::ProfilePage.new(self) }
end
