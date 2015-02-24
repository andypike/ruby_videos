module PageObjects
  module PresenterForm
    def element_prefix
      :presenter
    end

    def defaults
      @defaults ||= {
        :name    => "Sandi Metz",
        :twitter => "sandimetz",
        :github  => "torqueforge",
        :website => "www.sandimetz.com",
        :title   => "Author of POODR",
        :bio     => "Cyclist, Rubyist, reluctant author (poodr.com).",
        :photo   => File.expand_path("spec/support/files/image.jpg")
      }
    end
  end
end
