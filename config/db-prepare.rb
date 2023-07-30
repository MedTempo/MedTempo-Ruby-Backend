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

# Load the Graphql Queries on Memory

module DbPrepare
    def self.preload
        puts "\n"
        queries = Hash.new(Hash.new)
        Dir["./db-operations/*/*.gql"].each_with_index do
            | file, index |

            puts "#{index}) Query - #{file} [#{File.dirname(file).split('/').last}][#{File.basename(file, '.*')}]"

            #queries["#{File.dirname(file).split('/').last}"]["#{File.basename(file, '.*')}"] = File.read(file).gsub(/\s\s +/, ' ')

            queries["#{File.dirname(file).split('/').last}"] = queries["#{File.dirname(file).split('/').last}"].merge({ "#{File.basename(file, '.*')}" => File.read(file).gsub(/\s\s +/, ' ') })
        end

        puts "\nAll Queries Have Been Loaded!\n"


        return queries
    end
end 
