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

        logger.info user

        usr_type = user["user_type"].to_i

       if usr_type  == 1
        exists = JSON.parse(Db.execute(Db.db_operations["user-pessoal"]["select-one-with-pass"], { :user => user["email"] } , false))

        logger.info exists["data"]["usuario_pessoal"]

        if exists["data"]["usuario_pessoal"]["values"].empty? 
         usr_not_found = true
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

       if usr_not_found == true
        return halt 409, JSON.generate({ :message => "User Not Found" })
       end

        logger.info db_pass
        logger.info user["senha"] 
        pass_compare = Argon2::Password.verify_password user["senha"], db_pass, ENV["A2_SECRET"]

        logger.info pass_compare

        if db_usr == user["email"] && pass_compare == true
            expiration = Time.now.to_i + 3600
            session[:jwt] = JWT.encode({ :id => db_id, :user_type => usr_type , :ip => request.ip , :exp => expiration }, ENV["ENV_SECRET"], "HS512") 

            logger.info session[:jwt]
            body JSON.generate({ :recived => :logged_in })     
        else
            halt 401, JSON.generate({ :message => "user or password invalid" }) 
        end
    end end
end