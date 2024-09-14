FROM ruby:3.3.4

RUN apt-get update -qq && apt-get install -y default-mysql-client

RUN mkdir /test_app

WORKDIR /test_app

COPY Gemfile /test_app/Gemfile

COPY Gemfile.lock /test_app/Gemfile.lock

RUN gem update --system

RUN bundle update --bundler

RUN bundle install

COPY . /test_app

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
