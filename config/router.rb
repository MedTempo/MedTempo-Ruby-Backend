require "sinatra"

module Router
    def self.load

        puts "Loaded Controllers:"

        Dir["./routes/*/*.rb"].each_with_index do
            | file, index |

            require file

            puts "#{index}) Controller - #{file}"
        end

        puts "\n"
    end
end