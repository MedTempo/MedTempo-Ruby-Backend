require "sinatra"
require "jwt"

module Sinatra
  module Auth
    def protection!
       puts "You Shall Not Pass"
        begin
            puts JWT.decode session[:id], ENV["ENV_SECRET"], true, { :algorithm => "HS512" }
        rescue => exception
            puts "jwt nil"
        else
            
        end
    end
  end

  helpers Auth
end
