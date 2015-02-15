module Videos
  class Create < CRUD
    def model
      Video.new
    end
  end
end
