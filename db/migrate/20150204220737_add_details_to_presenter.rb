class AddDetailsToPresenter < ActiveRecord::Migration
  def change
    add_column :presenters, :twitter, :string, :default => "", :null => false
    add_column :presenters, :github, :string, :default => "", :null => false
    add_column :presenters, :website, :string, :default => "", :null => false
    add_column :presenters, :title, :string, :default => "", :null => false
    add_column :presenters, :bio, :text, :default => "", :null => false
    add_column :presenters, :photo, :string, :default => "", :null => false
  end
end
