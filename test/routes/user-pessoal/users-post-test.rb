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

require "test/unit"
require "rack/test"

module TestModule
    def test_1_UserPessoalPost

    
        mock_usr = {
            "nome"=>"#{(0...(rand(10) + 4)).map { ('a'..'z').to_a[rand(26)] }.join}",
            "sobrenome"=>"#{(0...(rand(10) + 4)).map { ('a'..'z').to_a[rand(26)] }.join}",
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
    
        puts "\n\n\n\n"
        
    end
end