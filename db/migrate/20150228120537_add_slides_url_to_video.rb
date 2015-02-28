class AddSlidesUrlToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :slides_url, :string, :default => "", :null => false
  end
end
