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

# Configure Cors Headers
module Cors
    def self.allow(allowed_origins = "*", methods = "POST, GET, PATCH, DELETE, OPTIONS", credentials = "true") 
        Sinatra::Application::before do 
            if allowed_origins.include?(request.env["HTTP_ORIGIN"].to_s) || 
                response.headers["Access-Control-Allow-Origin"] = request.env["HTTP_ORIGIN"] 
                response.headers["Access-Control-Allow-Methods"] = methods
                response.headers["Access-Control-Allow-Credentials"] = credentials

            elsif allowed_origins == "*"
                response.headers["Access-Control-Allow-Origin"] = "*"
                response.headers["Access-Control-Allow-Methods"] = methods
                response.headers["Access-Control-Allow-Credentials"] = credentials
            end
           content_type "application/json"
        end
    end
end