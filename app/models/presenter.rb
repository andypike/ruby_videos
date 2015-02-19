class Presenter < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  mount_uploader :photo, Presenters::PhotoUploader

  has_many :videos

  scope :ordered, -> { order(:name => :asc) }

  def self.random_published(max)
    with_published_videos
      .limit(max)
      .order("random")
  end

  def self.with_published_videos
    select("presenters.*, RANDOM() as random")
      .joins(:videos)
      .where(:videos => { :status => Video.statuses[:published] })
      .distinct
  end

  def self.list_for(user)
    return ordered if user.admin?

    ordered.with_published_videos
  end

  def published_videos
    videos.published
  end
end
