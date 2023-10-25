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
require "rack"
require "./config/cors"
require "./config/loader"
require "./config/worker-queue"

##
# Sinatra Configurations

include Rack
include Sinatra

#set :session_store, Rack::Session::Pool

#set :session_secret, 'your_secret'
#set :session_path, '/'
#set :session_key, 'rack.session'
set :sessions, true
set :session_secret, ENV["SESSION_SECRET"]

=begin use Rack::Protection,  :except => [:remote_token, :http_origin] 
use Rack::Session::Cookie, :key => 'rack.session',
:path => '/',
:secret => 'your_secret'
=end

Sinatra::Application::configure :production do
    Sinatra::Application::set :logging, false
    Sinatra::Application::set :bind, '0.0.0.0'
end

Sinatra::Application::configure :development do
    Sinatra::Application::set :logging, true
end  

Sinatra::Application::set :port, ENV["PORT"]

##
# Set Cors Headers
Cors::allow [ "https://med-tempo.vercel.app", "http://localhost:4200", "https://localhost:443", "capacitor://localhost", "ionic://localhost" ]

##
# Load Controllers
Load::router

##
# Load Helpers
Load::helpers




    #def self.defaults

        # Sinatra::Application::set :environment, :production

        ##
        # Enable sinatra sessions for store data with session[:key]
=begin        Sinatra::Application::set :sessions, true
        Sinatra::Application::set :protection, false

        ##
        # Enable configs acording the actual enviroment

        Sinatra::Application::configure do 
            Sinatra::Application::set :cookie_options do
                {
                    :same_site => :none,
                    :secure => true
                }
            end
        end
=end