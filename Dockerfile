#    Copyright © 2023 Felipe Chiozzotto Gozzani, Heloísa Real, Juliana Barbosa Sandes, Mateus Felipe da Silveira Vieira, Thiago Babtista da Silva Soares
#
#
#    MedTempo-Backend++ is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    MedTempo-Backend++ is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with MedTempo-Backend++.  If not, see <https://www.gnu.org/licenses/>5.

FROM ruby:latest as base 

WORKDIR /usr/src/MedTempo-Backend


COPY ./Gemfile* ./

RUN bundle install 

COPY ./ ./


EXPOSE 7777 
EXPOSE 9292


FROM base as dev

CMD [ "bundle", "exec", "rackup", "--port", "7777", "--host", "0.0.0.0" ]

FROM base as test

CMD [ "ruby", "./test/trigger-test.rb" ]

# New run with: sudo docker compose -f docker-compose.json build && sudo docker compose -f docker-compose.json up 

# Deprecated Run with: sudo docker build -t medtempo-backend --target dev . && sudo docker run -it --name backend-instance --rm --env-file .env --network host medtempo-backend
