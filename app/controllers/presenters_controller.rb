class PresentersController < ApplicationController
  before_action :ensure_admin
  before_action :build_form, :only => %i(create edit update)

  def index
    @presenters = Presenter.ordered
  end

  def new
    @form = Presenters::Form.new
  end

  def create
    Presenters::Create.new(@form)
      .on(:ok) { redirect_to presenters_path, :notice => t(:created_presenter) }
      .on(:fail) { render :new }
      .call
  end

  def edit
    presenter = Presenter.find(@form.id)

    AutoMapper.new(presenter).map_to(@form)
  end

  def update
    Presenters::Update.new(@form)
      .on(:ok) { redirect_to presenters_path, :notice => t(:updated_presenter) }
      .on(:fail) { render :edit }
      .call
  end

  private

  def build_form
    @form = Presenters::Form.build_from(:presenter, params)
  end
end
