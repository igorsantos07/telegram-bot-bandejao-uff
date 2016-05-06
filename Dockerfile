FROM ruby:2.3.1
RUN mkdir /app
WORKDIR /app
ADD . /app
RUN bundle install
