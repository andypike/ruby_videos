class VideosController < ApplicationController
  def index
    @videos = Video.list_for(current_user)
  end
end
