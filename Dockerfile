FROM ruby:2.7.3
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle --version
RUN bundle install
COPY . /app

CMD ["rails", "server"]