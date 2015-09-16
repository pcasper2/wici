if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.mailgun.org',
    port:           '587',
    authentication: :plain,
    user_name:      ENV['MAILGUN_USERNAME'],
    password:       ENV['MAILGUN_PASSWORD'],
    domain:         'app1971f245a68f44b5a32a7672553641f2.mailgun.org',
    enable_starttls_auto: true
  }
end