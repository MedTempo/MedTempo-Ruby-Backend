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
    def test_2_Medicine

        3.times do | i | 
            mock_usr = {
                "email"=> @@mock_email,
                "senha"=> @@mock_pass, 
                "user_type" => i + 1,
            }
    
            post "/login", JSON.generate(mock_usr), { "Content Type" => "application/json" }
    
            puts JSON.generate(last_response.body)
    
            assert last_response.ok?

            ###

            mock_medicine = {
                :id => "cd0ade88-de9d-4e44-8add-b2cdb29b6030",
                :usuario_especialista => "40c6a8fd-d835-4026-a423-94738a32b465",
                :usuario_pessoal => "60482f75-18c7-4406-a606-2d26b3f7d4fc",
                :nome => "Tilenol",
                :descricao => "Tilenol é um remedio que ajuda com ...",
                :intervalo_uso => "1 vez ao dia",
                :tempo_uso => "2023-07-05",
                :dosagem => "100ml",
                :metodo_uso => "Via oral",
                :reacoes_adversas => ["Enxaqueca"],
                :contra_indicacao => ["Pessoas Chatas", "Pessoas Saúdaveis"],
                :orientacao => "o remédio deve ser tomado de um jeito",
                :data_criacao => "2024-05-01",
                :expiration => 1000   
              }
    
            post "/medicine", JSON.generate(mock_medicine), { "Content Type" => "application/json" }

            puts last_response.body
    
            if (i + 1) == 2
                assert last_response.status == 200
            elsif (i + 1) == 2 || (i + 1) == 3
                assert last_response.status == 403
            end
    
            puts last_response.headers

            puts JSON.generate(last_response.body)
        end
    end

end 