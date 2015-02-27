class AddNewsletterOptInToUser < ActiveRecord::Migration
  def change
    add_column :users, :opted_into_newsletters, :boolean, :default => false, :null => false
  end
end
