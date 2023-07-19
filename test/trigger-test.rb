ENV["APP_ENV"] = "test"


require "./trigger"
require "test/unit"
require "rack/test"


class MedTempoTestes < Test::Unit::TestCase
    include Rack::Test::Methods

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
    
    def test_it_IndexGet
        get "/"

        assert last_response.ok?

        res = JSON.parse(last_response.body)

        assert res["data"]["keyspace"]["name"] == @@db_keyspace

        assert res["data"]["keyspace"]["tables"].empty? == false

        #puts res
    end


    def test_it_UserPessoalPost

    
        mock_usr = {
            :data_nascimento => Time.now.strftime("%Y-%m-%d"),
            :descricao => 100.times.map { (0...(rand(10))).map { ('a'..'z').to_a[rand(26)] }.join }.join(" "),
            :email => "#{(0...(rand(10))).map { ('a'..'z').to_a[rand(26)] }.join}@foo.com",
            :senha =>(0...(rand(15))).map { ('a'..'z').to_a[rand(26)] }.join,
            :idade => rand(127),
            :nome => (0...(rand(8))).map { ('a'..'z').to_a[rand(26)] }.join,
            :sexo => [ true, false ].sample,
            :nome => (0...(rand(7))).map { ('a'..'z').to_a[rand(26)] }.join,
        }

        puts mock_usr

        post "/user-pessoal", JSON.generate(mock_usr)

    
        assert last_response.ok?

        puts JSON.generate(last_response.body)
    
    end

    def test_it_UserPessoalPost_invalid_data

    
        mock_usr = {
            :data_nascimento => Time.now.strftime("%Y-%m-%d"),
            :descricao => 100.times.map { (0...(rand(10))).map { ('a'..'z').to_a[rand(26)] }.join }.join(" "),
            :email => "#{(0...(rand(10))).map { ('a'..'z').to_a[rand(26)] }.join}@foo.com",
            :senha =>(0...(rand(15))).map { ('a'..'z').to_a[rand(26)] }.join,
            :idade => rand(127),
            :nome => (0...(rand(8))).map { ('a'..'z').to_a[rand(26)] }.join,
            :sexo => [ true, false ].sample,
            #:nome => (0...(rand(7))).map { ('a'..'z').to_a[rand(26)] }.join,
        }

        puts mock_usr

        post "/user-pessoal", JSON.generate(mock_usr)

    
        assert last_response.ok?

        puts JSON.generate(last_response.body)
    
    end
end
