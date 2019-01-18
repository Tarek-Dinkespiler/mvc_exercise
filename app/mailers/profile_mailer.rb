# frozen_string_literal: true

class ProfileMailer < ApplicationMailer
  def notify_user(user)
    @user = user
    mail(to: @user.email, subject: "Test d'envoi d'email pour THP-next")
  end
end
