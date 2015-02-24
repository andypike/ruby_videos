FactoryGirl.define do
  factory :video do
    title       { Faker::Lorem.sentence }
    description "Blah blah blah blah blah blah blah"
    url         "http://youtube.com/12345"
    embed_code  "<embed>code</embed>"
    status      "draft"
    presenter
    suggestion  false

    factory :published_video do
      status "published"
    end

    factory :draft_video do
      status "draft"
    end

    factory :suggested_video do
      presenter  nil
      suggestion true
    end
  end
end
