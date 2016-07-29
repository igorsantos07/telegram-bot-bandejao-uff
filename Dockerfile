FROM hypriot/rpi-ruby:latest
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y libxml2-dev libxslt-dev build-essential patch pkg-config
WORKDIR /home
ADD . /home
RUN bundle install
