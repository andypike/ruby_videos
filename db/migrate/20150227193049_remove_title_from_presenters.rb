class RemoveTitleFromPresenters < ActiveRecord::Migration
  def change
    remove_column :presenters, :title, :string, :default => "", :null => false
  end
end
