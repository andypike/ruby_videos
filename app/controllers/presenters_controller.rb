class PresentersController < ApplicationController
  before_action :ensure_admin, :except => [:index, :show]

  def index
    @presenters = Presenter.list_for(current_user).page(params[:page])
  end

  def show
    @presenter = Presenter.friendly.find(params[:id])
    @videos = @presenter.videos_for(current_user)

    ensure_admin unless @presenter.published?
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
    presenter = Presenter.friendly.find(@form.id)

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
