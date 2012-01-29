require 'devise/strategies/database_authenticatable'

class Devise::Strategies::LoginSmsable < Devise::Strategies::DatabaseAuthenticatable
  def authenticate!
    super
  end
end