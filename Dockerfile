FROM ruby:latest

WORKDIR /usr/src/MedTempo-Backend


COPY ./Gemfile ./Gemfile

RUN bundle install 

COPY ./ ./


EXPOSE 7777 


CMD [ "ruby", "trigger.rb" ]


# Run with: sudo docker build -t medtempo-backend . && sudo docker run -it --env-file .env --network host medtempo-backend