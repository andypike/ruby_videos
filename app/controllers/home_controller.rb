class HomeController < ApplicationController
  def show
    @videos = Video.latest(9)
    @presenters = Presenter.random_published(3)
  end
end
