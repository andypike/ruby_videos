class PresentersController < ApplicationController
  before_action :ensure_admin

  def index
    @presenters = Presenter.ordered
  end
end
