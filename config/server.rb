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

require "sinatra/base"
require "./config/cors"
require "./config/loader"

##
# Sinatra Configurations
module ServerConfig
    def self.defaults

        # Sinatra::Application::set :environment, :production

        ##
        # Enable sinatra sessions for store data with session[:key]
        Sinatra::Application::set :sessions, true

        ##
        # Enable configs acording the actual enviroment
        if Sinatra::Application::production?
            Sinatra::Application::set :logging, false
            Sinatra::Application::set :bind, '0.0.0.0'
        else
            Sinatra::Application::set :logging, true    
        end

        Sinatra::Application::set :port, ENV["PORT"]
        
        ##
        # Set Cors Headers
        Cors::allow

        ##
        # Load Controllers
        Load::router

        ##
        # Load Helpers
        Load::helpers

    end
end