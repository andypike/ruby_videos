class User < ActiveRecord::Base
  enum :role => %i(viewer admin)

  def authenticated?
    true
  end
end
