FROM ruby:2.3.1

MAINTAINER "Gabriel Silva Vinha"

RUN gem install bundler

WORKDIR /usr/src/app

COPY . .

RUN bundle install

CMD ["rails", "puma"]

