class VideosController < ApplicationController
  before_action :ensure_admin, :except => :index

  def index
    @videos = Video.list_for(current_user)
  end

  def new
    @form = Videos::Form.new
  end

  def create
    @form = Videos::Form.build_from(:video, params)

    Videos::Create.new(@form)
      .on(:ok) { redirect_to videos_path, :notice => t(:created_video) }
      .on(:fail) { render :new }
      .call
  end

  def edit
    @form = Videos::Form.build_from(:video, params)
    video = Video.find(@form.id)

    AutoMapper.new(video).map_to(@form)
  end

  def update
    @form = Videos::Form.build_from(:video, params)

    Videos::Update.new(@form)
      .on(:ok) { redirect_to videos_path, :notice => t(:updated_video) }
      .on(:fail) { render :edit }
      .call
  end
end
