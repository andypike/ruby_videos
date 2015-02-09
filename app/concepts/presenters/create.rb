module Presenters
  class Create < CRUD
    def model
      Presenter.new
    end
  end
end
