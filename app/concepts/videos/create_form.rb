module Videos
  class CreateForm < Form
    route_as :video

    attribute :user, User

    validates :user, :presence => true
  end
end
