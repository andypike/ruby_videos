class SuggestionsController < ApplicationController
  def new
    @form = Videos::SuggestionForm.new
  end

  def create
    @form = Videos::SuggestionForm.build_from(:suggestion, params)

    Videos::CreateSuggestion.call(@form, current_user)
      .on(:ok) { redirect_to videos_path, :notice => t(:created_suggestion) }
      .on(:fail) { render :new }
  end
end
