module Videos
  class Update < CRUD
    def model
      Video.find(form.id)
    end
  end
end
