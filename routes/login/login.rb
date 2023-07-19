
require "sinatra"
require "./config/database"
require "json"
require "argon2"

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
         return JSON.generate({ :error => "User Not Found" })
        end

       db_pass = exists["data"]["usuario_pessoal"]["values"][0]["hash_senha"]
       db_usr = exists["data"]["usuario_pessoal"]["values"][0]["email"]
       elsif usr_type == 2
        return body JSON.generate({ :user => "user_especialista" })

       elsif usr_type == 3
        return body JSON.generate({ :user => "user_familha" })
       else
        return body JSON.generate({ :error => "user_type_not_found" })
       end

        puts db_pass
        puts user["senha"] 
        pass_compare = Argon2::Password.verify_password user["senha"], db_pass

        puts pass_compare

        if db_usr == user["email"] && pass_compare == true
            body JSON.generate({ :recived => :logged_in })     
        else
            body JSON.generate({ :error => "user or password invalid" }) 
        end
    end end
end