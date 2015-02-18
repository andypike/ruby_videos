class HomeController < ApplicationController
  def show
    @videos = Video.latest(9)
    @presenters = Presenter.with_published_videos(3)
  end
end
