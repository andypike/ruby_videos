class Presenter < ActiveRecord::Base
  mount_uploader :photo, Presenters::PhotoUploader

  has_many :videos

  scope :ordered, -> { order(:name => :asc) }

  def self.random(max)
    limit(max).order("RANDOM()")
  end

  def published_videos
    videos.published
  end
end
