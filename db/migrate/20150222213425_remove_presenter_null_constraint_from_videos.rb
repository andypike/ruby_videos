class RemovePresenterNullConstraintFromVideos < ActiveRecord::Migration
  def change
    change_column_null :videos, :presenter_id, true
  end
end
