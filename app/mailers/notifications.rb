class Notifications < ActionMailer::Base
  default :from => "robe5.agf@gmail.com"

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
  
  #   en.notifications.new_user.subject
  def new_user(user)
    @user = user
    mail :to => user.email
  end
end
