class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: default_i18n_subject
  end
end
