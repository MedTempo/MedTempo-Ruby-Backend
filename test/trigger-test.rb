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


Dir["./test/routes/*/*.rb"].each_with_index do
    | file, index |

    require file

    puts "#{index}) Test - #{file}"
end

puts "\nAll Tests Have Been Loaded!\n\n"

module TestModule
    @@db_id = ENV["DB_ID"]
    @@db_region = ENV["DB_REGION"]
    @@db_keyspace = ENV["DB_KEYSPACE"]
    @@db_app_token = ENV["DB_APPLICATION_TOKEN"]

    @@uri_struct = "https://#{@db_id}-#{@@db_region}.apps.astra.datastax.com/api/graphql";

    @@db_uri = "#{@@uri_struct}/#{@@db_keyspace}";
    @@db_uri_schema = "#{@@uri_struct}-schema"

    @@mock_email =  "#{(0...(rand(10) + 4)).map { ('a'..'z').to_a[rand(26)] }.join}@foo.com"
    @@mock_pass =  "#{(0...(rand(10) + 4)).map { ('a'..'z').to_a[rand(26)] }.join}"  

end

class MedTempoTestes < Test::Unit::TestCase
    include Rack::Test::Methods
    include TestModule
    self.test_order = :defined

    def app
        Sinatra::Application
    end
end
