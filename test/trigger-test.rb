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

ENV["APP_ENV"] = "test"


require "./trigger"
require "test/unit"
require "rack/test"


class MedTempoTestes < Test::Unit::TestCase
    include Rack::Test::Methods
    self.test_order = :defined

    @@db_id = ENV["DB_ID"]
    @@db_region = ENV["DB_REGION"]
    @@db_keyspace = ENV["DB_KEYSPACE"]
    @@db_app_token = ENV["DB_APPLICATION_TOKEN"]

    @@uri_struct = "https://#{@@db_id}-#{@@db_region}.apps.astra.datastax.com/api/graphql";

    @@db_uri = "#{@@uri_struct}/#{@@db_keyspace}";
    @@db_uri_schema = "#{@@uri_struct}-schema"

    def app
        Sinatra::Application
    end
    
    def test_it_IndexGet_Error
        get "/"

        assert last_response.status == 400

        res = JSON.parse(last_response.body)

        #assert res["data"]["keyspace"]["name"] == @@db_keyspace

        #assert res["data"]["keyspace"]["tables"].empty? == false

        #puts res
    end



    @@mock_email =  "#{(1...(rand(10))).map { ('a'..'z').to_a[rand(26)] }.join}@foo.com"
    @@mock_pass =  "#{(1...(rand(10))).map { ('a'..'z').to_a[rand(26)] }.join}"

    def test_it_UserPessoalPost

    
        mock_usr = {
            "nome"=>"oi",
            "sobrenome"=>"ooi",\
            "idade"=>23, 
            "sexo"=>"true", 
            "email"=> @@mock_email,
            "senha"=> @@mock_pass, 
            "data_nascimento"=>"2023-08-04", 
            "descricao"=>"ddd"
        }
        

        puts mock_usr

        post "/user-pessoal", JSON.generate(mock_usr), { "Content Type" => "application/json" }

        puts JSON.generate(last_response.body)
    
        assert last_response.ok?
    
    end


    def test_it_Login 
        mock_usr = {
            "email"=> @@mock_email,
            "senha"=> @@mock_pass, 
            "user_type" => 1,
        }

        post "/login", JSON.generate(mock_usr), { "Content Type" => "application/json" }

        puts JSON.generate(last_response.body)

        assert last_response.ok?

        get "/"

        assert last_response.ok?

        puts last_response.headers

    end    
end
