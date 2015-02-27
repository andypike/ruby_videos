module Users
  class EditProfileForm < FormObject
    route_as :user

    attribute :opted_into_newsletters, :boolean, :default => false
  end
end
