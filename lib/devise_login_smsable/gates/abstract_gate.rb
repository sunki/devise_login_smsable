# Base gate, other gates should be inherited from it
module DeviseLoginSmsable::Gates
  class AbstractGate
    attr_reader :api_url

    # Default sms message
    def message
      'Authentication code: '
    end

    private

    def config
      DeviseLoginSmsable::Main.config
    end

    def send_request *params_keys
      resp = post_request prepare_request(params_keys)

      resp_body = resp.code == '200' ? resp.body.split : []

      { :http_code => resp.code,
        :gate_code => resp_body[0],
        :sms_id => resp_body[1]
      }
    end

    def post_request params_hash
      uri = URI.parse api_url

      http = Net::HTTP.new uri.host, uri.port
      req = Net::HTTP::Post.new uri.request_uri
      
      req.set_form_data params_hash
      resp = http.request req
    end

    # Builds hash for request based on passed config keys
    def prepare_request params
      Hash[ params.map{ |p| [p, config.send(p)] } ]
    end
  end
end
