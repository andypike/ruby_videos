class SessionsController < ApplicationController
  def create
    info = Authentication::OmniAuthInfo.new(env["omniauth.auth"])

    Authentication::LoginWithOmniAuth.call(info, warden)
      .on(:ok)   { redirect_to root_path, :notice => t(:login_success) }
      .on(:fail) { redirect_to root_path, :alert => t(:login_fail) }
  end

  def destroy
    warden.logout
    redirect_to root_path, :notice => t(:logout_success)
  end
end
