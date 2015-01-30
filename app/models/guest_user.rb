class GuestUser
  def authenticated?
    false
  end

  def id
    :logged_out
  end

  def name
    "Guest"
  end
end
