class VideoMailer < ActionMailer::Base
  def suggestion(video)
    @video = video

    mail(
      :to => Rails.configuration.suggestions_email,
      :subject => "A new Ruby Videos suggestion"
    )
  end
end
