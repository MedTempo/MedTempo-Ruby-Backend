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


# Run with: sudo docker build -t medtempo-backend . && sudo docker run -it --env-file .env --network host medtempo-backend