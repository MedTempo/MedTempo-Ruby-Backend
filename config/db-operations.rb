module DbOperations
    def self.preload
        puts "\n"
        queries = {}
        Dir["./db-operations/*/*.gql"].each_with_index do
            | file, index |

            puts "#{index}) Query - #{file}"

            queries["#{File.basename(file, ".*")}-#{File.dirname(file).split('/').last}"] = File.read(file).gsub(/\s\s +/, ' ')

            #puts File.read file    
        end

        #puts queries

        puts "\nAll Queries Have Been Loaded!\n"

        return queries
    end
end 