class Presenter < ActiveRecord::Base
  mount_uploader :photo, Presenters::PhotoUploader

  has_many :videos

  scope :ordered, -> { order(:name => :asc) }

  def self.random_published(max)
    with_published_videos
      .limit(max)
      .order("RANDOM()")
  end

  def self.with_published_videos
    joins(:videos)
      .where(:videos => { :status => Video.statuses[:published] })
  end

  def published_videos
    videos.published
  end
end
