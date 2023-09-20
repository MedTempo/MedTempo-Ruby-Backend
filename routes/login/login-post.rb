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
        table_name = "usuario_pessoal"
        query_name = "user-pessoal"
       elsif usr_type == 2
        table_name = "usuario_especialista"
        query_name = "user-especialista"
       elsif usr_type == 3
        table_name = "usuario_familiar"
        query_name = "user-familiar"
       else
        halt 400, JSON.generate({ :message => "User Type Not Found" })
       end

       exists = Db.execute(Db.db_operations[query_name]["select-one-with-pass"], { :user => user["email"] } , false)

       puts exists

       logger.info exists["data"][table_name]

       if exists["data"][table_name]["values"].empty? 
        return halt 409, JSON.generate({ :message => "User Not Found" })
       end

        db_pass = exists["data"][table_name]["values"][0]["hash_senha"]
        db_usr = exists["data"][table_name]["values"][0]["email"]
        db_id = exists["data"][table_name]["values"][0]["id"]
       

        logger.info db_pass
        logger.info user["senha"] 
        pass_compare = Argon2::Password.verify_password user["senha"], db_pass, ENV["A2_SECRET"]

        logger.info pass_compare

        if db_usr == user["email"] && pass_compare == true
            expiration = Time.now.to_i + 3600
            session[:jwt] = JWT.encode({ :id => db_id, :user => db_usr, :user_type => usr_type , :ip => request.ip , :exp => expiration }, ENV["ENV_SECRET"], "HS512") 

            logger.info session[:jwt]
            body JSON.generate({ :recived => :logged_in })     
        else
            halt 401, JSON.generate({ :message => "user or password invalid" }) 
        end
    end end
end