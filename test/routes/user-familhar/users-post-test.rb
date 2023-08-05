require "test/unit"
require "rack/test"

module TestModule
    def test_1_UserFamilharPost

    
        mock_usr = {
            "nome"=>"oi",
            "sobrenome"=>"ooi",
            "sexo"=>"true", 
            "email"=> @@mock_email,
            "senha"=> @@mock_pass, 
            "data_nascimento"=>"2023-08-04", 
            "parentesco": "teste parentesco",
            "local_trabalho": "Trabalho Legal",            
        }


        puts mock_usr

        post "/user-familhar", JSON.generate(mock_usr), { "Content Type" => "application/json" }

        puts JSON.generate(last_response.body)
    
        assert last_response.ok?

        puts "\n\n\n\n"
    
    end
end