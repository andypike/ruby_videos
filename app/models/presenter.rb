class Presenter < ActiveRecord::Base
  scope :ordered, -> { order(:name => :asc) }
end
