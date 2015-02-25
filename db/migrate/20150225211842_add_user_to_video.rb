class AddUserToVideo < ActiveRecord::Migration
  def change
    add_reference :videos, :user, :index => true, :null => false

    add_foreign_key :videos, :users
  end
end
