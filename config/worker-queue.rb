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


require "bunny"
require "json"

puts "Bunny: #{ENV["RMQ_HOST"]}"

puts "Starting Bunny (Rabbitmq driver) ..."

Rabbitmq = Hash.new

Rabbitmq[:connection] = Bunny.new hostname: ENV["RMQ_HOST"], port: ENV["RMQ_PORT"].to_i, virtual_host: ENV["RMQ_VHOST"], username: ENV["RMQ_USR"], password: ENV["RMQ_PASS"], connection_timout:  60000
Rabbitmq[:instance] = Rabbitmq[:connection].start               
Rabbitmq[:channel] = Rabbitmq[:instance].create_channel

Rabbitmq[:queues] = {
    :emails => Rabbitmq[:channel].queue("emails", durable: true)
}

puts "Rabbitmq connection established"


#Rabbitmq[:queues][:queue].publish("My Queue is Working", persistent: true)
