module PageObjects
  class MainMenu < PageObject
    def login_as(role)
      return if role == :guest

      create(:admin) if role == :admin
      login_link.click
    end

    def login_link
      find_link("Login with GitHub")
    end

    def logout_link
      find_link("Logout")
    end

    def profile_link
      find_link("Profile")
    end
  end
end

module PageObjectHelpers
  let(:main_menu) { PageObjects::MainMenu.new(self) }
end
