class Video < ActiveRecord::Base
  mount_uploader :cover, Videos::CoverUploader

  belongs_to :presenter

  enum :status => %i(draft published)

  scope :ordered, -> { order(:created_at => :desc) }

  def self.latest(max)
    ordered.published.limit(max)
  end
end
