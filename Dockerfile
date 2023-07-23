FROM ruby:latest as base 

WORKDIR /usr/src/MedTempo-Backend


COPY ./Gemfile ./Gemfile

RUN bundle install 

COPY ./ ./


EXPOSE 7777 


FROM base as dev

CMD [ "ruby", "trigger.rb" ]


FROM base as test

CMD [ "ruby", "./test/trigger-test.rb" ]


FROM base as docs

WORKDIR /usr/src/MedTempo-Backend

RUN rdoc 

CMD [ "ruby", "trigger.rb" ]


# Run with: sudo docker build -t medtempo-backend --target dev . && sudo docker run -it --name backend-instance --rm --env-file .env --network host medtempo-backend
