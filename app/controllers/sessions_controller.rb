class SessionsController < ApplicationController
  def create
    info = Authentication::OmniAuthInfo.new(env["omniauth.auth"])

    Authentication::LoginWithOmniAuth.new(info)
      .on(:success) { redirect_to root_path, :notice => t(:login_success) }
      .on(:fail)    {}
      .call
  end
end
