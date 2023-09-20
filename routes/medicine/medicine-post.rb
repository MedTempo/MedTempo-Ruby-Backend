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
require "./config/database"
require "json"
require "securerandom"
require "date"

module MedicinePost
    ["/medicine"].each do | path | Sinatra::Application::post path do
        auth = protection!([2])
        
        medicine = JSON.parse(request.body.read)

        verify! medicine,[
            #"usuario_especialista",
            "usuario_pessoal",
            "nome",
            "descricao",
            "intervalo_uso",
            "tempo_uso",
            "dosagem",
            "metodo_uso",
            "reacoes_adversas",
            "contra_indicacao",
            "orientacao",
          ]

        medicine["usuario_especialista"] = auth["user"]
        medicine["id"] = SecureRandom.uuid
        medicine["data_criacao"] = Time.now.strftime("%Y-%m-%d")

        medicine["expiration"] = (Date.parse(medicine["tempo_uso"]) - Date.today).to_i * (3600 * 24) * 5

         #  logger.info "\n\n\n\n\n\n\n\n\n#{medicine[:expiration]}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
         puts "\n\n\n\n\n\n\n\n\nlooooger"
         puts JSON.generate(medicine)
         puts "\n\n\n\n\n\n\n\n\n"

        post = Db.execute(Db.db_operations["medicamentos"]["insert"], medicine, false)

        body post
    end end

end