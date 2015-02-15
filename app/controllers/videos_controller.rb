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
end
