class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :default => "", :null => false
      t.text :description, :default => "", :null => false
      t.references :presenter, :index => true, :null => false
      t.string :url, :default => "", :null => false
      t.text :embed_code, :default => "", :null => false
      t.integer :status, :default => 0, :null => false
      t.string :cover, :default => "", :null => false

      t.timestamps :null => false
    end

    add_foreign_key :videos, :presenters
  end
end
