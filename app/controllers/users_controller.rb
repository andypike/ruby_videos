class UsersController < ApplicationController
  before_action :ensure_authenticated

  def edit
    @form = Users::EditProfileForm.new

    AutoMapper.new(current_user).map_to(@form)
  end

  def update
    @form = Users::EditProfileForm.build_from(:user, params)

    Users::Update.call(@form, current_user)
      .on(:ok) { redirect_to edit_profile_path, :notice => t(:updated_profile) }
      .on(:fail) { render :edit }
  end
end
