FactoryGirl.define do
  factory :video do
    title       "All the little things"
    description "Blah blah blah blah blah blah blah"
    url         "http://youtube.com/12345"
    embed_code  "<embed>code</embed>"
    status      "published"
    presenter
  end
end
