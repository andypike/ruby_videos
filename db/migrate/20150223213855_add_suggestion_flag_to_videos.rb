class AddSuggestionFlagToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :suggestion, :boolean, :default => false, :null => false
  end
end
