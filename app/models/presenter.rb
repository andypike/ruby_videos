class Presenter < ActiveRecord::Base
  mount_uploader :photo, Presenters::PhotoUploader

  scope :ordered, -> { order(:name => :asc) }

  def self.random(max)
    limit(max).order("RANDOM()")
  end
end
