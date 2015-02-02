module PageObjects
  class MainMenu < PageObject
    def login_as(role)
      create(:admin) if role == :admin
      login_link.click
    end

    def presenters_link
      find_link("Presenters")
    end

    def login_link
      find_link("Login with GitHub")
    end

    def logout_link
      find_link("Logout")
    end
  end

  def main_menu
    MainMenu.new(self)
  end
end
