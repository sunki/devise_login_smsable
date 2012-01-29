module Devise
  module Models
    module LoginSmsable
      extend ActiveSupport::Concern

      included do
        # Rewrites authenticate controllers filters that control current model
        DeviseLoginSmsable::Main.add_hook_for name

        attr_accessor :remote_ip
        attr_protected :sms_code_expire, :sms_code_valid
      end

      def login_smsable_config
        DeviseLoginSmsable::Main.config
      end

      # After log-in hook
      def after_database_authentication
        reset_sms_code!
        send_sms_code!
        super
      end

      def reset_sms_code!
        self.sms_code = generate_sms_code
        self.sms_code_valid = false
        self.sms_code_expire = Time.now + login_smsable_config.sms_code_expire
        save!
      end

      def send_sms_code!
        gate = DeviseLoginSmsable::Main.gate
        phone_digits = phone.gsub /\D+/, ''

        resp = gate.deliver! phone_digits, sms_code
        
        log! 'sms code sent, server response: ' + resp.inspect
      end

      def sms_or_ip_valid?
        privileged_ip? || sms_code_valid?
      end

      def privileged_ip?
        privileged_ips = login_smsable_config.privileged_ips
        privileged_ips && privileged_ips.include?(remote_ip)
      end

      def sms_code_valid?
        sms_code && sms_code_valid && !sms_code_expire?
      end

      def sms_code_expire?
        if !sms_code_expire || sms_code_expire < Time.now
          reset_sms_code!
          true
        else
          false
        end
      end

      def log!
        Rails.logger.info
      end

      def generate_sms_code
        length = login_smsable_config.sms_code_length
        
        symbols = [(0..9),('A'..'Z')].map(&:to_a).flatten
        (0..length).map{ symbols[rand(symbols.size)] }.join
      end
    end
  end
end