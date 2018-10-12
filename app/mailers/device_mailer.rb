class DeviseMailer < Devise::Mailer
  layout 'mailer'
  default template_path: 'devise/mailer'
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  # def confirmation_instructions(record, token, opts={})
  #   headers["Custom-header"] = "Confirm registration"
  #   super
  # end
  #
  def confirmation_instructions(record, token, opts={})
    if record.email.present?
      opts[:subject] = "Welcome #{record.email.split('@').first.capitalize}, Confirm your account"
    else
      opts[:subject] = "Confirm your account"
    end

    super
  end
end