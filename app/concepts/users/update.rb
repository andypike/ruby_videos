module Users
  class Update
    include Nala::Publisher

    attr_reader :form, :user

    def initialize(form, user)
      @form = form
      @user = user
    end

    def call
      if form.valid?
        AutoMapper.new(form).map_to(user).tap do |u|
          u.save!

          publish(:ok, u)
        end
      else
        publish(:fail)
      end
    end
  end
end
