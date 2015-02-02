class PresentersController < ApplicationController
  before_action :ensure_admin

  def index
    @presenters = Presenter.ordered
  end

  def new
    @form = Presenters::Form.new
  end

  def create
    @form = Presenters::Form.new(params[:presenter])

    Presenters::Create.new(@form)
      .on(:ok)   { redirect_to presenters_path, :notice => t(:added_presenter) }
      .on(:fail) { render :new }
      .call
  end
end
