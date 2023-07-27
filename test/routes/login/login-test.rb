require "test/unit"
require "rack/test"


module TestModule
    def test_2_Login 
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

        puts last_response.cookies

    end

end