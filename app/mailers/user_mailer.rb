class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: default_i18n_subject
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("pass_reset")
  end
end
