require "sinatra"

module UsersGet
    ["/user"].each do |path| Sinatra::Application::get path do
            body "hello"      
    end end
end