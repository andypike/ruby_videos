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
    run :operation => Presenters::Create,
        :ok_notice => t(:created_presenter),
        :fail_view => :new
  end

  def edit
    presenter = Presenter.find(@form.id)

    AutoMapper.new(presenter).map_to(@form)
  end

  def update
    run :operation => Presenters::Update,
        :ok_notice => t(:updated_presenter),
        :fail_view => :edit
  end

  private

  def build_form
    @form = Presenters::Form.build_from(:presenter, params)
  end

  def run(options)
    operation = options.fetch(:operation)
    fail_view = options.fetch(:fail_view)
    ok_notice = options.fetch(:ok_notice)

    operation.new(@form)
      .on(:ok)   { redirect_to presenters_path, :notice => ok_notice }
      .on(:fail) { render fail_view }
      .call
  end
end
