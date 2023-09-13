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
require "date"
require "mail"

module TestModule
=begin    def test_2_CadastroVerify
        Mail.defaults do
            retriever_method :pop3, :address    => "pop.gmail.com",
                                    :port       => 995,
                                    :user_name  => ENV["EMAIL_USR"],
                                    :password   => ENV["EMAIL_PASS"],
                                    :enable_ssl => true
          end

        puts Mail.all

        puts "\n\n\n\n\n\n\n\n\n END email"
    end
=end
end 