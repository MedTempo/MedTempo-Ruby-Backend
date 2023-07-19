require "sinatra"

module OptCors
    Sinatra::Application::options "*" do
        response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
        status 200
    end
end
