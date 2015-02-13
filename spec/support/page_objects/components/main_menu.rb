module PageObjects
  class MainMenu < PageObject
    def login_as(role)
      create(:admin) if role == :admin
      login_link.click
    end

    def login_link
      find_link("Login with GitHub")
    end

    def logout_link
      find_link("Logout")
    end
  end
end

module PageObjectHelpers
  let(:main_menu) { PageObjects::MainMenu.new(self) }
end
