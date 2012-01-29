# config/routes.rb not loads by Engine
# TODO: To fix
module ActionDispatch::Routing
  class Mapper
    def login_smsable
      resources :login_smsable
    end
  end
end
