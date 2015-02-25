class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  mount_uploader :cover, Videos::CoverUploader

  belongs_to :presenter
  belongs_to :user

  enum :status => %i(draft published)

  scope :ordered, -> { order(:created_at => :desc) }

  def self.latest(max)
    ordered.published.limit(max)
  end

  def self.list_for(user)
    return ordered if user.admin?

    ordered.published
  end

  def presenter_name
    return "Unknown" if presenter.blank?

    presenter.name
  end
end
