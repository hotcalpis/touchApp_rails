ActionMailer::Base.add_delivery_method(
  :ses,
  AWS::SES::Base,
  access_key_id: ENV['AWS_ACCESS_KEY_ID_SES']
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY_SES'],
  server: 'email.us-west-2.amazonaws.com'
)