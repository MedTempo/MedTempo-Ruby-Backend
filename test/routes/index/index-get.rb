require "test/unit"
require "rack/test"

module TestModule
    def test_IndexGet_Error
        get "/"

        assert last_response.status == 400

        res = JSON.parse(last_response.body)

        #assert res["data"]["keyspace"]["name"] == @@db_keyspace

        #assert res["data"]["keyspace"]["tables"].empty? == false

        #puts res
    end
end