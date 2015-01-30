class GuestUser
  def authenticated?
    false
  end

  def id
    :guest
  end

  def name
    "Guest"
  end
end
