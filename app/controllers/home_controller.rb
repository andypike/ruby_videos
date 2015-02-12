class HomeController < ApplicationController
  def show
    @presenters = Presenter.random(3)
  end
end
