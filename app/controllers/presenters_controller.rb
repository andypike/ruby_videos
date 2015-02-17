class PresentersController < ApplicationController
  before_action :ensure_admin, :except => :index

  def index
    @presenters = Presenter.ordered.page(params[:page])
  end

  def new
    @form = Presenters::Form.new
  end

  def create
    @form = Presenters::Form.build_from(:presenter, params)

    Presenters::Create.new(@form)
      .on(:ok) { redirect_to presenters_path, :notice => t(:created_presenter) }
      .on(:fail) { render :new }
      .call
  end

  def edit
    @form     = Presenters::Form.build_from(:presenter, params)
    presenter = Presenter.find(@form.id)

    AutoMapper.new(presenter).map_to(@form)
  end

  def update
    @form = Presenters::Form.build_from(:presenter, params)

    Presenters::Update.new(@form)
      .on(:ok) { redirect_to presenters_path, :notice => t(:updated_presenter) }
      .on(:fail) { render :edit }
      .call
  end
end
