class PresentersController < ApplicationController
  before_action :ensure_admin, :except => :index

  def index
    @presenters = Presenter.ordered
  end

  def new
    @form = Presenters::Form.new
  end

  def create
    @form = Presenters::Form.build_from(:presenter, params)

    run :operation => Presenters::Create,
        :ok_notice => t(:created_presenter),
        :fail_view => :new
  end

  def edit
    @form     = Presenters::Form.build_from(:presenter, params)
    presenter = Presenter.find(@form.id)

    AutoMapper.new(presenter).map_to(@form)
  end

  def update
    @form = Presenters::Form.build_from(:presenter, params)

    run :operation => Presenters::Update,
        :ok_notice => t(:updated_presenter),
        :fail_view => :edit
  end

  private

  def run(operation:, ok_notice:, fail_view:)
    operation.new(@form)
      .on(:ok)   { redirect_to presenters_path, :notice => ok_notice }
      .on(:fail) { render fail_view }
      .call
  end
end
