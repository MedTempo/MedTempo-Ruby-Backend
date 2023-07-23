
require "sinatra"
require "./config/database"
require "json"
require "argon2"
require "jwt"


# Realize Login for any type of user
module LoginPost
    ["/login"].each do | path | Sinatra::Application::post path do

        content_type "application/json"

        user = JSON.parse(request.body.read)

        puts user

        usr_type = user["user_type"].to_i

       if usr_type  == 1
        exists = JSON.parse(Db.execute(Db.db_operations["user-pessoal"]["select-one-with-pass"], { :user => user["email"] } , false))

        puts exists["data"]["usuario_pessoal"]

        if exists["data"]["usuario_pessoal"]["values"].empty? 
         return halt 409, JSON.generate({ :message => "User Not Found" })
        end

       db_pass = exists["data"]["usuario_pessoal"]["values"][0]["hash_senha"]
       db_usr = exists["data"]["usuario_pessoal"]["values"][0]["email"]
       db_id = exists["data"]["usuario_pessoal"]["values"][0]["id"]
       elsif usr_type == 2
        return body JSON.generate({ :user => "user_especialista" })

       elsif usr_type == 3
        return body JSON.generate({ :user => "user_familha" })
       else
        halt 400, JSON.generate({ :message => "user_type_not_found" })
       end

        puts db_pass
        puts user["senha"] 
        pass_compare = Argon2::Password.verify_password user["senha"], db_pass, ENV["A2_SECRET"]

        puts pass_compare

        if db_usr == user["email"] && pass_compare == true
            expiration = Time.now.to_i + 3600
            session[:jwt] = JWT.encode({ :id => db_id, :user_type => usr_type , :ip => request.ip , :exp => expiration }, ENV["ENV_SECRET"], "HS512") 

            puts session[:jwt]
            body JSON.generate({ :recived => :logged_in })     
        else
            halt 401, JSON.generate({ :message => "user or password invalid" }) 
        end
    end end
end