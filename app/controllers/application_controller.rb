class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception
  helper_method :current_user

  def current_user
    @current_user ||= warden.current_user
  end

  private

  def warden
    @warden ||= Authentication::Warden.new(session)
  end

  def ensure_admin
    return if current_user.admin?

    redirect_to root_path, :alert => t(:not_authorised)
  end

  def ensure_authenticated
    return if current_user.authenticated?

    redirect_to root_path, :alert => t(:not_authorised)
  end
end
