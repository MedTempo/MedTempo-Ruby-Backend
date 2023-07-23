require "sinatra"
require "json"

# Checks if user is authenticated, if not send a error back to client
module Sinatra
  module Auth
    def protection!
       puts "Protection Helper Begin:"


      if session[:jwt].kind_of? String 

        begin
          jwt = JWT.decode session[:jwt], ENV["ENV_SECRET"], true, { :algorithm => "HS512" }
  
          puts jwt
        rescue JWT::InvalidIssuerError => error
          puts error
          halt 401, JSON.generate({ :message => "You Shall Not Pass! Invalid Token" })
        end
      else
          halt 400, JSON.generate({ :message => "Invalid Token Format" })
      end

    end
  end

  helpers Auth
end
