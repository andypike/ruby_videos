FactoryGirl.define do
  factory :user do
    nickname  "andypike"
    name      "Andy Pike"
    image_url "http://somewhere.com/andy.jpg"
    provider  "github"
    uid       "12345"
    role      "viewer"
    opted_into_newsletters true

    factory :admin do
      role "admin"
    end

    factory :viewer do
      role "viewer"
    end

    factory :user_with_random_uid do
      uid SecureRandom.uuid
    end
  end
end
