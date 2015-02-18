FactoryGirl.define do
  factory :presenter do
    name { Faker::Name.name }

    factory :presenter_with_published_video do
      after(:create) do |presenter, _|
        create(:published_video, :presenter => presenter)
      end
    end

    factory :presenter_with_draft_video do
      after(:create) do |presenter, _|
        create(:draft_video, :presenter => presenter)
      end
    end
  end
end
