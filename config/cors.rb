module Cors
    def self.allow(origin = "*", methods = "POST, GET, PATCH, DELETE") 
        Sinatra::Application::before do 
            headers["Access-Control-Allow-Origin"] = origin
            headers["Access-Control-Allow-Methods"] = methods
        end
    end
end