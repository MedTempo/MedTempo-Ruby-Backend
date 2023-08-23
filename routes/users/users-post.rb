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
        verify! user,  ["nome", "sobrenome", "sexo", "email", "senha", "data_nascimento", "descricao" ]

        req_email = JSON.parse(Db.execute(Db.db_operations["user-pessoal"]["select-one"], { :user => user["email"] }, false))
        
        puts req_email

        if req_email["data"]["usuario_pessoal"]["values"].empty? == false
            logger.info req_email
            return halt 409, JSON.generate({ :message => "error #{user["email"]} exists" })
        end

        logger.info user
        user["id"] = SecureRandom.uuid
            
        if user["sexo"] == "true"
            user["sexo"] = true
        elsif user["sexo"] == "false"
            user["sexo"] = false
        end

        argon2 = Argon2::Password.new(secret: ENV["A2_SECRET"])
        user["senha"] = argon2.create(user["senha"])
        user["data_criacao"] = Time.now.strftime("%Y-%m-%d")
        
        res = Db.execute(Db.db_operations["user-pessoal"]["insert"], user, false)

        Rabbitmq[:queues][:emails].publish JSON.generate({ :to => user["email"], :for => "welcome", :usr_type => 1 })

        logger.info res
        body JSON.generate({ :message => "ok" })           
    end end

    ["/user-especialista"].each do | path | Sinatra::Application::post path do
        
        user = JSON.parse(request.body.read)
        verify! user, ["nome", "sobrenome", "sexo", "email", "senha", "data_nascimento", "crm", "local_trabalho"]

        req_email = JSON.parse(Db.execute(Db.db_operations["user-especialista"]["select-one"], { :user => user["email"] }, false))
        
        logger.info req_email

        if req_email["data"]["usuario_especialista"]["values"].empty? == false
            logger.info req_email
            return halt 409, JSON.generate({ :message => "error #{user["email"]} exists" })
        end

        logger.info user
        user["id"] = SecureRandom.uuid
            
        if user["sexo"] == "true"
            user["sexo"] = true
        elsif user["sexo"] == "false"
            user["sexo"] = false
        end

        argon2 = Argon2::Password.new(secret: ENV["A2_SECRET"])
        user["senha"] = argon2.create(user["senha"])
        user["data_criacao"] = Time.now.strftime("%Y-%m-%d")
        

        res = Db.execute(Db.db_operations["user-especialista"]["insert"], user, false)
        Rabbitmq[:queues][:emails].publish JSON.generate({ :to => user["email"], :for => "welcome", :usr_type => 2 })

        logger.info res
        body JSON.generate({ :message => "ok" })           
    end end

    ["/user-familiar"].each do | path | Sinatra::Application::post path do
        
        user = JSON.parse(request.body.read)

        verify! user, [ "nome", "sobrenome", "sexo", "email", "senha", "data_nascimento", "local_trabalho" ]

        req_email = JSON.parse(Db.execute(Db.db_operations["user-familiar"]["select-one"], { :user => user["email"] }, false))

        puts req_email
            
        if req_email["data"]["usuario_familiar"]["values"].empty? == false
            logger.info req_email
            return halt 409, JSON.generate({ :message => "error #{user["email"]} exists" })
        end

        logger.info user
        user["id"] = SecureRandom.uuid
            
        if user["sexo"] == "true"
            user["sexo"] = true
        elsif user["sexo"] == "false"
            user["sexo"] = false
        end

        argon2 = Argon2::Password.new(secret: ENV["A2_SECRET"])
        user["senha"] = argon2.create(user["senha"])
        user["data_criacao"] = Time.now.strftime("%Y-%m-%d")
        

        res = Db.execute(Db.db_operations["user-familiar"]["insert"], user, false)
        Rabbitmq[:queues][:emails].publish JSON.generate({ :to => user["email"], :for => "welcome", :usr_type => 3 })   

        logger.info res
        body JSON.generate({ :message => "ok" })           
    end end
end