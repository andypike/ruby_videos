class Presenter < ActiveRecord::Base
  mount_uploader :photo, Presenters::PhotoUploader

  scope :ordered, -> { order(:name => :asc) }
end
