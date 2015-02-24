class SuggestionsController < ApplicationController
  def new
    @form = Videos::SuggestionForm.new
  end

  def create
    @form = Videos::SuggestionForm.build_from(:suggestion, params)

    Videos::CreateSuggestion.new(@form)
      .on(:ok) { redirect_to videos_path, :notice => t(:created_suggestion) }
      .on(:fail) { render :new }
      .call
  end
end
