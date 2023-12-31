=begin

    Copyright © 2023 Felipe Chiozzotto Gozzani, Heloísa Real, Juliana Barbosa Sandes, Mateus Felipe da Silveira Vieira, Thiago Babtista da Silva Soares


    MedTempo-Backend++ is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    MedTempo-Backend++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with MedTempo-Backend++.  If not, see <https://www.gnu.org/licenses/>5.
    
=end

require "sinatra"
require "json"
require "./errors/user-permissions"

# Checks if user is authenticated, if not send a error back to client
module Sinatra
  module Auth
    def protection!(allowed = [1,2,3])
       logger.info "Protection Helper Begin:"

   
      #if session[:jwt].kind_of? String 

        begin
          jwt = JWT.decode session[:jwt], ENV["ENV_SECRET"], true, { :algorithm => "HS512" }
          logger.info jwt

         if request.ip == jwt[0]["ip"]
          logger.info "ok"
         else
          raise "Ivalid Host"
         end

        #puts jwt[0]
        #puts "\n\n\n\n\n\nPermision type for #{jwt[0]["user_type"]} is #{allowed.include?(jwt[0][]) == false}\n\n\n\n\n"

        if allowed.include?(jwt[0]["user_type"]) == false
          raise PermissionErr
        end

        rescue JWT::DecodeError, JWT::ExpiredSignature => error
          logger.info error
          session[:jwt] = nil
          halt 401, JSON.generate({ :message => "You Shall Not Pass! #{error}" })

        rescue PermissionErr => error
          logger.info error
          session[:jwt] = nil
          halt 403, JSON.generate({ :message => "You dont have necessary permission to proceed. Error for #{jwt[0]["user_type"]}" })
    
        rescue => error
          logger.info error
          session[:jwt] = nil
          halt 500, JSON.generate({ :message => "Something Wrong is Not Right! #{error}" })
    
        end

      #else
      #    session.inspect
      #    halt 400, JSON.generate({ :message => "Invalid Token Format" })
      #end

      return jwt[0]
    end
  end

  helpers Auth
end
