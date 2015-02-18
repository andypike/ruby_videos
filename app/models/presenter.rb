class Presenter < ActiveRecord::Base
  mount_uploader :photo, Presenters::PhotoUploader

  has_many :videos

  scope :ordered, -> { order(:name => :asc) }

  def self.with_published_videos(max)
    joins(:videos)
      .where(:videos => { :status => Video.statuses[:published] })
      .limit(max)
      .order("RANDOM()")
  end

  def published_videos
    videos.published
  end
end
