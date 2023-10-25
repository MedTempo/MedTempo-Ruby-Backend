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
    def test_IndexGet_Error
        get "/"
    
        puts last_response.status
        assert last_response.status == 401

        res = JSON.parse(last_response.body)

        #assert res["data"]["keyspace"]["name"] == @@db_keyspace

        #assert res["data"]["keyspace"]["tables"].empty? == false

        #puts res
    end
end