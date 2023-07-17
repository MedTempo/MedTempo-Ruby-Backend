require "sinatra"

module IndexGet
    ["/", "/hello"].each do | path | Sinatra::Application::get path do
            body "hello"      
    end end
end