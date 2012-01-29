DeviseLoginSmsable::Main.setup do |config|
  config.gate = :smsru
  config.sms_code_expire = 30
  config.phone_column_name = 'phone'
  config.privileged_ips = %(127.0.0.3)
  config.sms_code_length = 5
end
