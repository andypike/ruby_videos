class Video < ActiveRecord::Base
  mount_uploader :cover, Videos::CoverUploader

  belongs_to :presenter

  scope :ordered, -> { order(:created_at => :desc) }

  def self.latest(max)
    ordered.limit(max)
  end
end
