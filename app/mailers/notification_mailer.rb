# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def send_password_for_github_registration(user)
    @user = user
    mail to: @user.email, subject: 'Githubでの登録を完了しました。'
  end
end
