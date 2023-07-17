require "sinatra/base"
require "./config/cors"
require "./config/router"

module ServerConfig
    def self.defaults

        # Sinatra::Application::set :environment, :production

       if Sinatra::Application::production?
        Sinatra::Application::set :logging, false
       else
        Sinatra::Application::set :logging, true
       end

        Sinatra::Application::set :port, ENV["PORT"]
        Cors::allow
        Router::load
    end
end