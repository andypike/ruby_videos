module MailHelpers
  def email_with_subject(subject)
    ActionMailer::Base
      .deliveries
      .select { |m| m.subject.include?(subject) }
      .last
  end
end
