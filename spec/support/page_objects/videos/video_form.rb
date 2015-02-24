module PageObjects
  module VideoForm
    def element_prefix
      :video
    end

    def defaults
      @defaults ||= {
        :title        => "All the little things",
        :description  => Faker::Lorem.paragraph,
        :presenter_id => Presenter.first.id,
        :url          => Faker::Internet.url,
        :embed_code   => "<embed><embed>",
        :status       => "draft",
        :cover        => File.expand_path("spec/support/files/image.jpg")
      }
    end
  end
end
