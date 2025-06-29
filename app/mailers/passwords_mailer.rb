class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    # mail subject: "Reset your password", to: user.email_address
    from = SendGrid::Email.new(email: Rails.application.credentials.config[:default_from_email])
    to = SendGrid::Email.new(email: @user.email_address)
    content = SendGrid::Content.new(
      type: "text/plain",
      value: "You can reset your password within the next 15 minutes on this password reset page:
#{edit_password_url(@user.password_reset_token)}"
    )
    message = SendGrid::Mail.new(from, "Reset your password", to, content)
    sg = SendGrid::API.new(api_key: Rails.application.credentials.config[:SMTP_PASSWORD])
    sg.client.mail._("send").post(request_body: message.to_json)
  end

  def welcome(user)
    @user = user
    from = SendGrid::Email.new(email: Rails.application.credentials.config[:default_from_email])
    to = SendGrid::Email.new(email: @user.email_address)
    content = SendGrid::Content.new(
      type: "text/html",
      value: "<html><body><p>Welcome to the ENC-HEAL TEACH app #{@user.name}.</p><p>Please reset your password within the next 15 minutes on this password reset page:
#{edit_password_url(@user.password_reset_token)}</p><p>If you are unable to do so, you can request a new password reset link using this email address on this page:
#{new_password_url()}</p></body></html>"
    )
    message = SendGrid::Mail.new(from, "Welcome to TEACH", to, content)
    sg = SendGrid::API.new(api_key: Rails.application.credentials.config[:SMTP_PASSWORD])
    sg.client.mail._("send").post(request_body: message.to_json)
  end
end
