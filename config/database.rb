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

require "sinatra"
require "net/http"
require "json"
require "./config/db-prepare"


# Class to connect to Cassandra On Datastax by Graphql API
class Cassandra

    attr_reader :db_operations
    attr_reader :db_keyspace

    def initialize(config)

        @db_operations = DbPrepare::preload

        @db_id = config[:id]
        @db_region = config[:region]
        @db_keyspace = config[:keyspace]
        @db_app_token = config[:token]

        @uri_struct = "https://#{@db_id}-#{@db_region}.apps.astra.datastax.com/api/graphql";

        @db_uri = "#{@uri_struct}/#{@db_keyspace}";
        @db_uri_schema = "#{@uri_struct}-schema"

        self.show
        #self.is_filled
    end

    private def show 
        if Sinatra::Application::production?
            raise "It's not allowed to read the env variables in production"
        else
            puts "\n"
            puts "Region: #{@db_region}\nId: #{@db_id}\nKeyspace: #{@db_keyspace}\nToken: #{@db_app_token}\nDb base uri: #{@uri_struct}\nDb uri: #{@db_uri}\nDb schema uri: #{@db_uri_schema}"       
            puts "\n"
        end
    end

    def is_filled
        if @db_regions == false
            raise "Not defined"
        end
    end

    def execute(query, vars = {}, adm = false)

       if adm == false
        uri = URI(@db_uri)
       elsif 
        uri = URI(@db_uri_schema)
       end

    

        res = Net::HTTP.post uri, JSON.generate({ :query => query, :variables => vars }) , {
            "Content-Type" => "application/json",
            "X-Cassandra-Token" => @db_app_token
        }

        if res.is_a?(Net::HTTPSuccess) != true
            puts res.body
            raise "\u274c Db Error #{res.code}!"
        end

        return res.body
    end
end

Db = Cassandra.new({
    :id => ENV["DB_ID"],
    :region => ENV["DB_REGION"],
    :keyspace => ENV["DB_KEYSPACE"],
    :token => ENV["DB_APPLICATION_TOKEN"],
})
