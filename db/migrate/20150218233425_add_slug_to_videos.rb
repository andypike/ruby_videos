class AddSlugToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :slug, :string
    add_index :videos, :slug, unique: true
  end
end
