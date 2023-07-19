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
require "securerandom"
require "json"
require "argon2"

module UsersPost
    ["/user-pessoal", "/usuarios"].each do | path | Sinatra::Application::post path do
        
        user = JSON.parse(request.body.read)

        if (
            (user["id"].kind_of? String)                == false ||
            (user["data_criacao"].kind_of? String)      == false ||
            (user["data_nascimento"].kind_of? String)   == false ||  
            (user["descricao"].kind_of? String)         == false ||
            (user["email"].kind_of? String)             == false ||
            (user["hash_senha"].kind_of? String)        == false ||
            (user["idade"].kind_of? String)             == false ||  
            (user["nome"].kind_of? Number)              == false ||
            (user["sexo"].kind_of? String)              == false ||
            (user["sobrenome"].kind_of? String)         == false       
        )
            status 400
            return JSON.generate({ :error => :info_missing })
        end


        req_email = JSON.parse(Db.execute(Db.db_operations["user-pessoal"]["select-one"], { :user => user["email"] }, false))
            
        if req_email["data"]["usuario_pessoal"]["values"].empty? == false
            puts req_email
            content_type "application/json"
            return "error #{user["email"]} exists"
        end

        puts user
        user["id"] = SecureRandom.uuid
            
        if user["sexo"] == "true"
            user["sexo"] = true
        elsif user["sexo"] == "false"
            user["sexo"] = false
        end

        argon2 = Argon2::Password.new
        user["senha"] = argon2.create(user["senha"])
        user["data_criacao"] = Time.now.strftime("%Y-%m-%d")
        

        res = Db.execute(Db.db_operations["user-pessoal"]["insert"], user, false)

        puts res

        content_type "application/json"
        body res           
    end end
end