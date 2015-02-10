module Presenters
  class Update < CRUD
    def model
      Presenter.find(form.id)
    end
  end
end
