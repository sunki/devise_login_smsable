module DeviseLoginSmsable
  class Main
    class Config
      attr_accessor :api_id, :to, :text, :test
    end
  end

  module Gates
    class Smsru < AbstractGate

      def initialize
        @api_url = 'http://sms.ru/sms/send'
      end

      def deliver! recipient, sms_code
        config.to = recipient
        config.text = message + sms_code
        config.test = 0

        send_request :api_id, :to, :text, :test
      end

    end
  end
end
