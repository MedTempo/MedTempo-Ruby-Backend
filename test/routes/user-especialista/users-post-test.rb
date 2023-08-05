require "test/unit"
require "rack/test"


module TestModule
    def test_1_UserEspecialistaPost

    
        mock_usr = {
            "nome"=>"oi",
            "sobrenome"=>"ooi",
            "sexo"=>"true", 
            "email"=> @@mock_email,
            "senha"=> @@mock_pass, 
            "data_nascimento"=>"2023-08-04", 
            "crm": "CRM/SP 123456",
            "local_trabalho": "Consultório Legal",            
        }


        puts mock_usr

        post "/user-especialista", JSON.generate(mock_usr), { "Content Type" => "application/json" }

        puts JSON.generate(last_response.body)
    
        assert last_response.ok?


        puts "\n\n\n\n"
    
    end
end