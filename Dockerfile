FROM ruby:2.4.4

WORKDIR /tmp/acceptance

RUN apt-get update && apt-get install -y firefox-esr xvfb

ADD Gemfile /tmp/acceptance/Gemfile
RUN bundle install

ADD . /tmp/acceptance
RUN chmod +x ./pre-commit.sh
RUN gem install bundler
ENV DISPLAY :10
ENV RUN_XVFB true
CMD ./pre-commit.sh
