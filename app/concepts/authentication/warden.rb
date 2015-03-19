module Authentication
  class Warden
    attr_reader :store

    def initialize(store)
      @store = store
    end

    def current_user
      User.find_by(:id => user_id) || GuestUser.new
    end

    def login(user)
      self.current_user = user
    end

    def logout
      self.current_user = GuestUser.new
    end

    private

    def current_user=(user)
      store[:user_id] = user.id
    end

    def user_id
      store[:user_id]
    end
  end
end
