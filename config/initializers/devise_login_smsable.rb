DeviseLoginSmsable::Main.setup do |config|
  config.gate = :smsru

  # Sms code grants access only for specified period (in seconds)
  config.sms_code_expire = 600

  # Column name used to store cell phone numbers
  config.phone_column_name = 'phone'

  # Some IPs can access without sms code checking
  config.privileged_ips = %(127.0.0.3)

  config.sms_code_length = 5
end
