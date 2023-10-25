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
=begin
require "test/unit"
require "rack/test"
require "date"
require "mail"

module TestModule
    def test_2_CadastroVerify
        Mail.defaults do
            retriever_method :imap, :address    => "imap.gmail.com",
                                    :port       => 993,
                                    :user_name  => ENV["EMAIL_USR"],
                                    :password   => ENV["EMAIL_PASS"],
                                    :enable_ssl => true
          end

          #puts Mail.all

          teste = imap.select('"[Gmail]/Sent Mail"')

          puts teste

          puts Mail.all

          puts "END all mails"
    end
end 
=end