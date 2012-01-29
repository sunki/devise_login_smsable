require 'devise'

$:.push File.expand_path('../devise_login_smsable', __FILE__)

require 'exceptions'
require 'hooks'
require 'routing'
require 'strategy'
require 'gates/abstract_gate'
require 'gates/smsru'

module DeviseLoginSmsable
  # Engine not loads automatically since Rails 3.0
  class Engine < Rails::Engine
  end

  class Main
    cattr_accessor :config, :models, :gate

    class Config
      attr_accessor :sms_code_expire, :sms_code_length, :phone_column_name, :privileged_ips, :gate
    end

    def self.init
      @@config = Config.new
      @@models = []

      Warden::Strategies.add :login_smsable, Devise::Strategies::LoginSmsable

      Devise.add_module :login_smsable, :strategy => true, :model => 'model'
    end

    def self.setup
      yield config
    end

    def self.gate
      @@gate ||= DeviseLoginSmsable::Gates.const_get(config.gate.to_s.capitalize).new
    end

    # Rewrites standart Devise authenticate filters to add functionality of devise_login_smsable gem
    # As standart filters loads dynamically on each request (depending on environment) we also need do the same
    def self.add_hook_for model
      resource = model.underscore
      models << resource if !models.include?(resource)

      ActiveSupport.on_load(:action_controller) do
        before_filter do
          code = <<-src
            def authenticate_#{resource}!(opts={})
              user = super
              if user
                user.remote_ip = request.remote_ip

                if params[:controller] != 'login_smsable' && !user.sms_or_ip_valid?
                  redirect_to "/login_smsable/#{resource}/edit"
                end
              end
            end
          src
          instance_eval code
        end
      end
    end
  end
end

DeviseLoginSmsable::Main.init