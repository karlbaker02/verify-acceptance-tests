FROM ruby:2.4.2

ADD Gemfile Gemfile

RUN bundle install

ENTRYPOINT ["bundle", "exec", "cucumber"]
