class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception
  helper_method :current_user

  CURRENT_USER_KEY = :user_id

  private

  def current_user
    if session[CURRENT_USER_KEY].present?
      @current_user ||= User.find_by(:id => session[CURRENT_USER_KEY])
    end

    @current_user || GuestUser.new
  end

  def set_current_user(user, notice)
    session[CURRENT_USER_KEY] = user.id
    redirect_to root_path, :notice => t(notice)
  end

  def ensure_admin
    return if current_user.admin?

    redirect_to root_path, :alert => t(:not_authorised)
  end
end
