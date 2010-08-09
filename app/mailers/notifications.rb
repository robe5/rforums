class Notifications < ActionMailer::Base
  default :from => "forums@forums.local"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.password_recovery.subject
  #
  def password_recovery(user)
    @token = user.reset_password_code
    @until_time = user.reset_password_code_until

    mail :to => user.email
  end
end