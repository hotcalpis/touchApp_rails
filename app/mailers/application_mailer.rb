# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'touchApp <noreply@touchapp.tk>'
  layout 'mailer'
end
