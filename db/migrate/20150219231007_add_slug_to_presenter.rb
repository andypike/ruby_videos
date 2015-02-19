class AddSlugToPresenter < ActiveRecord::Migration
  def change
    add_column :presenters, :slug, :string
    add_index :presenters, :slug, unique: true
  end
end
