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

# Checks if user is authenticated, if not send a error back to client
module Sinatra
  module Auth
    def protection!
       logger.info "Protection Helper Begin:"


      if session[:jwt].kind_of? String 

        begin
          jwt = JWT.decode session[:jwt], ENV["ENV_SECRET"], true, { :algorithm => "HS512" }
          logger.info jwt

         if request.ip == jwt[0]["ip"]
          logger.info "ok"
         elsif 
          raise "ivalid Host"
         end

        rescue => error
          logger.info error
          session[:jwt] = nil
          halt 401, JSON.generate({ :message => "You Shall Not Pass! #{error}" })
        end
      else
          halt 400, JSON.generate({ :message => "Invalid Token Format" })
      end

    end
  end

  helpers Auth
end
