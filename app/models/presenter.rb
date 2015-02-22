class Presenter < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, :use => :slugged

  mount_uploader :photo, Presenters::PhotoUploader

  has_many :videos, -> { order(:created_at => :desc) }

  scope :ordered, -> { order(:name => :asc) }

  def self.random_published(max)
    where(
      :id => select(:id).with_published_videos
    ).limit(max).order("RANDOM()")
  end

  def self.with_published_videos
    joins(:videos)
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

  def published?
    published_videos.present?
  end

  def videos_for(user)
    return videos if user.admin?

    published_videos
  end
end
