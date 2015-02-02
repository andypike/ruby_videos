class SessionsController < ApplicationController
  def create
    info = Authentication::OmniAuthInfo.new(env["omniauth.auth"])

    Authentication::LoginWithOmniAuth.new(info)
      .on(:ok)   { |user| set_current_user(user, :login_success) }
      .on(:fail) { redirect_to root_path, :alert => t(:login_fail) }
      .call
  end

  def destroy
    set_current_user(GuestUser.new, :logout_success)
  end
end
