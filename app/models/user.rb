class User < ActiveRecord::Base
  enum :role => %i(viewer admin)
end
