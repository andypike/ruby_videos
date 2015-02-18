FactoryGirl.define do
  factory :video do
    title       { Faker::Lorem.sentence }
    description "Blah blah blah blah blah blah blah"
    url         "http://youtube.com/12345"
    embed_code  "<embed>code</embed>"
    status      "draft"
    presenter

    factory :published_video do
      status "published"
    end

    factory :draft_video do
      status "draft"
    end
  end
end
