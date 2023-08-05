require "test/unit"
require "rack/test"

module TestModule
    def test_1_UserPessoalPost

    
        mock_usr = {
            "nome"=>"oi",
            "sobrenome"=>"ooi",
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