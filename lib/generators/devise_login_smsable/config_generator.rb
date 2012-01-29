class DeviseLoginSmsable::ConfigGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../config/initializers', __FILE__)

  def create_initializer_file
    copy_file 'devise_login_smsable.rb', 'config/initializers/devise_login_smsable.rb'
  end
end
